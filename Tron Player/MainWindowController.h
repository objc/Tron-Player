//
//  MainWindowController.h
//  Tron Player
//
//  Copyright 2011 George L. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class iTunesApplication, HoverButton, CircularProgressView;

@interface MainWindowController : NSWindowController {
@private
	iTunesApplication *iTunesApp;
	
	NSTimer *progressTimer;
	
	IBOutlet HoverButton *prev;
	IBOutlet HoverButton *next;
	IBOutlet HoverButton *play;
	IBOutlet NSTextField *labelName;
	IBOutlet NSTextField *labelSong;
	IBOutlet NSTextField *labelTime;
	
	IBOutlet CircularProgressView *progressView;
}

- (IBAction)prevClick:(id)sender;
- (IBAction)playClick:(id)sender;
- (IBAction)nextPlay:(id)sender;

@end
