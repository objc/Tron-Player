//
//  CircularProgressView.m
//  Tron Player
//
//  Copyright 2011 George L. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CircularProgressView : NSView {

	CGFloat _r;
	CGFloat _g;
	CGFloat _b;
	CGFloat _a;

	CGFloat progress;
	
	CGRect _outerCircleRect;
	CGRect _innerCircleRect;
}

@property (nonatomic, assign) CGFloat progress;

- (void)setColourR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

@end
