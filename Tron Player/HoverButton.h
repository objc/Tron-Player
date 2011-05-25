//
//  HoverButton.h
//  Forismatic
//
//  Copyright 2011 George L. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HoverButton : NSButton {
@private
	NSTrackingArea *trackingArea;
	NSImage *hoverImage;
	NSImage *originalImage;
	
	BOOL hoverIsChanging;
}

@property (retain) NSImage *hoverImage;

@end
