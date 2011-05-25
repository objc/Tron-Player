//
//  MainWindowController.m
//  Tron Player
//
//  Copyright 2011 George L. All rights reserved.
//

#import "MainWindowController.h"
#import "HoverButton.h"
#import "CircularProgressView.h"
#import "iTunes.h"

@interface MainWindowController ()
- (void)updateInfoFromItunes;
- (void)updateCurrentState;
- (void)timerFireMethod:(NSTimer*)theTimer;
@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
		iTunesApp = [[SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"] retain];

		NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
		[dnc addObserver:self selector:@selector(updateTrackInfo:)
					name:@"com.apple.iTunes.playerInfo"
				  object:nil];
		
		progressTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5
														  target:self
														selector:@selector(timerFireMethod:)
														userInfo:nil
														 repeats:YES] retain];
		[progressTimer fire];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];

	[[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
	[progressTimer invalidate], [progressTimer release];
	[iTunesApp release];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
}

- (void)awakeFromNib
{
	NSImage *prevImage = [NSImage imageNamed:@"prev.png"];
	[prev setImage:prevImage];
	[prev setFocusRingType:NSFocusRingTypeNone];
	[prev setBordered:NO];
	[prev setAutoresizingMask:NSViewMinYMargin];
	[prev setButtonType:NSMomentaryChangeButton];

	NSImage *nextImage = [NSImage imageNamed:@"next.png"];
	[next setImage:nextImage];
	[next setFocusRingType:NSFocusRingTypeNone];
	[next setBordered:NO];
	[next setAutoresizingMask:NSViewMinYMargin];
	[next setButtonType:NSMomentaryChangeButton];

	NSImage *playImage = [NSImage imageNamed:@"play.png"];
	[play setImage:playImage];
	[play setFocusRingType:NSFocusRingTypeNone];
	[play setBordered:NO];
	[play setAutoresizingMask:NSViewMinYMargin];
	[play setButtonType:NSMomentaryChangeButton];
	
	[[labelName cell] setBackgroundStyle:NSBackgroundStyleLowered];
	[[labelSong cell] setBackgroundStyle:NSBackgroundStyleLight];
	
	[self updateInfoFromItunes];
	[self updateCurrentState];
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    if (iTunesApp == nil || ![iTunesApp isRunning])
	{
		[progressView setProgress:0.0];
		[labelTime setStringValue:@"00:00"];
		return;
	}

	double duration = [[iTunesApp currentTrack] duration];
	double position = (double)[iTunesApp playerPosition];
	double progress;
	
	if (position == 0)
		progress = 0;
	else
		progress = position / duration;
		
	[progressView setProgress:progress];
	
	NSUInteger m, s;
	m = position / 60;
	s = position - (m * 60);
	
	[labelTime setStringValue:[NSString stringWithFormat:@"%.2d:%.2d", m, s]];
}

- (void) updateTrackInfo:(NSNotification *)notification
{
    if (iTunesApp == nil || ![iTunesApp isRunning]) 
        return;
	
	NSDictionary *information = [notification userInfo];

	if ([information valueForKey:@"Album"] != nil)
		[labelName setStringValue:[information valueForKey:@"Album"]];
	else
		[labelName setStringValue:@""];

	if ([information valueForKey:@"Name"] != nil)
		[labelSong setStringValue:[information valueForKey:@"Name"]];
	else
		[labelSong setStringValue:@""];
	
	[self updateCurrentState];
}

- (void)updateInfoFromItunes
{
    if (iTunesApp == nil || ![iTunesApp isRunning]) 
	{
		[labelSong setStringValue:@""];
		[labelName setStringValue:@""];
        return;
	}
	
	iTunesTrack *theCurrentTrack = [iTunesApp currentTrack];
    if (theCurrentTrack == nil)
    {
		return;
    }

	NSString *currentTrackName = [theCurrentTrack name];
    if (currentTrackName == nil)
	{
		return;
	}
	
	[labelSong setStringValue:currentTrackName];
	[labelName setStringValue:[theCurrentTrack album]];
}

- (void)updateCurrentState
{
    if (iTunesApp == nil || ![iTunesApp isRunning]) 
        return;

	switch ([iTunesApp playerState]) {
		case iTunesEPlSPlaying:
			[play setImage:[NSImage imageNamed:@"pause.png"]];
			break;
			
		default:
			[play setImage:[NSImage imageNamed:@"play.png"]];
			break;
	}
}

- (IBAction)prevClick:(id)sender
{
    if (![iTunesApp isRunning])
		return;

	[iTunesApp previousTrack];
}

- (IBAction)playClick:(id)sender
{
    if (![iTunesApp isRunning])	[iTunesApp run];
	
	[iTunesApp playpause];
	[self updateCurrentState];
}

- (IBAction)nextPlay:(id)sender
{
    if (![iTunesApp isRunning])
		return;
	
	[iTunesApp nextTrack];
}

@end
