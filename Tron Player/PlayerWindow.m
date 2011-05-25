//
//  PlayerWindow.m
//  Tron Player
//
//  Copyright 2011 George L. All rights reserved.
//

#import "PlayerWindow.h"


@implementation PlayerWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle
				  backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
	NSImage *backImage = [NSImage imageNamed:@"main2.png"];
	
//	NSRect rect = [[NSScreen mainScreen] frame];
	contentRect = NSMakeRect(contentRect.origin.x, //rect.size.width / 2 - [backImage size].width /2,
							 contentRect.origin.y, //rect.size.height / 2 - [backImage size].height /2,
							 [backImage size].width, [backImage size].height);
    
	self = [super initWithContentRect:contentRect
							styleMask:NSBorderlessWindowMask
							  backing:NSBackingStoreBuffered
								defer:NO];
	
	if (self) {
		NSColor *backColor = [NSColor colorWithPatternImage:backImage];
		[self setBackgroundColor:backColor];
		[self setMovableByWindowBackground:YES];
		[self setLevel:NSStatusWindowLevel];
		[self setOpaque:NO];
		[self setHasShadow:NO];
	}
	
    return self;
}

- (BOOL)canBecomeKeyWindow
{
	return YES;
}

- (BOOL)canBecomeMainWindow
{
	return YES;
}

- (void)dealloc
{
    [super dealloc];
}

@end
