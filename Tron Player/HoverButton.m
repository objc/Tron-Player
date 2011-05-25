//
//  HoverButton.m
//  Forismatic
//
//  Copyright 2011 George L. All rights reserved.
//

#import "HoverButton.h"


@implementation HoverButton

@synthesize hoverImage;

- (void)updateTrackingAreas
{
	[super updateTrackingAreas];

	if (trackingArea)
	{
		[self removeTrackingArea:trackingArea];
		[trackingArea release];
	}

	NSTrackingAreaOptions options = NSTrackingInVisibleRect | 
									NSTrackingAssumeInside |
									NSTrackingMouseEnteredAndExited |
									NSTrackingActiveAlways;
	trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
												options:options
												  owner:self
											   userInfo:nil];
	[self addTrackingArea:trackingArea];
}

- (void)setImage:(NSImage *)image
{
	[super setImage:image];

	if (!hoverIsChanging) {
		originalImage = [image copy];
	}	
}

- (void)mouseEntered:(NSEvent *)event
{
	if (hoverImage != nil) {
		hoverIsChanging = YES;
		[self setImage:hoverImage];
		hoverIsChanging = NO;
	}
}

- (void)mouseExited:(NSEvent *)event
{
	if (hoverImage != nil && originalImage != nil) {
		hoverIsChanging = YES;
		[self setImage:originalImage];
		hoverIsChanging = NO;
	}
}

- (void)dealloc
{
	self.hoverImage = nil;
	[originalImage release];
	
	[super dealloc];
}

@end
