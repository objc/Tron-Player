//
//  CircularProgressView.m
//  Tron Player
//
//  Copyright 2011 George L. All rights reserved.
//

#import "CircularProgressView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CircularProgressView

@synthesize progress;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_r = 0.1;
		_g = 0.9;
		_b = 1;
		_a = 1.0;
		
		progress = 0;
		
		// FIXME: a lot of magic numbers
		int radius, x, y;
		if (frame.size.width > frame.size.height) {
			radius = frame.size.height;
			radius -= 7;
			int delta = frame.size.width - radius;
			x = delta / 2;
			y = 4;
		}else {
			radius = frame.size.width;
			radius -= 7;
			int delta = frame.size.height - radius;
			y = delta / 2;
			x = 6;
		}
		
		_outerCircleRect = CGRectMake(x, y, radius, radius);
		CGFloat r = 6;
		_innerCircleRect = CGRectMake(x+r, y+r, radius-2*r, radius-2*r);
	}
	return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextSaveGState(context);
	
	CGGradientRef myGradient;
	size_t num_locations = 3;
	CGFloat locations[3] = { 0.0, 0.5, 1.0 };

	CGPoint myStartPoint, myEndPoint; 
	CGFloat myStartRadius, myEndRadius; 
	myStartPoint.x = _innerCircleRect.origin.x + _innerCircleRect.size.width / 2; 
	myStartPoint.y = _innerCircleRect.origin.y + _innerCircleRect.size.width / 2;
	myEndPoint.x = _innerCircleRect.origin.x + _innerCircleRect.size.width / 2;
	myEndPoint.y = _innerCircleRect.origin.y + _innerCircleRect.size.width / 2;
	myStartRadius = _innerCircleRect.size.width / 2;
	myEndRadius = _outerCircleRect.size.width / 2;
	 
	CGContextMoveToPoint(context,
						 _outerCircleRect.origin.x + _outerCircleRect.size.width / 2, // move to the top center of the outer circle
						 _outerCircleRect.origin.y + 1); // the Y is one more because we want to draw inside the bigger circles.

	CGFloat startAngel, endAngel;
	startAngel = M_PI / 2;
	endAngel = M_PI / 2 - progress * 2 * M_PI;

	CGContextAddArc(context,
					_outerCircleRect.origin.x + _outerCircleRect.size.width / 2,
					_outerCircleRect.origin.y + _outerCircleRect.size.width / 2,
					_outerCircleRect.size.width / 2 - 1,
					startAngel,
					endAngel, 1);
	CGContextAddArc(context, 
					 _outerCircleRect.origin.x + _outerCircleRect.size.width / 2,
					 _outerCircleRect.origin.y + _outerCircleRect.size.width / 2,
					 _outerCircleRect.size.width / 2 - 9,
					 endAngel,
					 startAngel, 1);

	CGContextClosePath(context);
	CGContextClip(context);

	CGFloat components2[12] = {
		_r, _g, _b, _a,
		((_r + 0.5 > 1) ? 1 : (_r + 0.5)),
		((_g + 0.5 > 1) ? 1 : (_g + 0.5)),
		((_b + 0.5 > 1) ? 1 : (_b + 0.5)),
		((_a + 0.5 > 1) ? 1 : (_a + 0.5)),
		_r, _g, _b, _a
	};
	
	CGColorSpaceRef myColorspace;
	myColorspace = CGColorSpaceCreateDeviceRGB();
	
	myGradient = CGGradientCreateWithColorComponents(myColorspace,
													 components2,
													 locations,
													 num_locations);
	 
	myStartPoint.x = _innerCircleRect.origin.x + _innerCircleRect.size.width / 2; 
	myStartPoint.y = _innerCircleRect.origin.y + _innerCircleRect.size.width / 2;
	myEndPoint.x = _innerCircleRect.origin.x + _innerCircleRect.size.width / 2;
	myEndPoint.y = _innerCircleRect.origin.y + _innerCircleRect.size.width / 2;

	// set the radius for start and endpoints a bit smaller,
	// because we want to draw inside the outer circles.
	myStartRadius = _innerCircleRect.size.width / 2 + 1;
	myEndRadius = _outerCircleRect.size.width / 2 - 1;
	
	CGContextDrawRadialGradient(context,
								myGradient,
								myStartPoint,
								myStartRadius,
								myEndPoint,
								myEndRadius,
								0);

	CGGradientRelease(myGradient);
	CGColorSpaceRelease(myColorspace);

	// draw circle on the outline to smooth it out.
	CGContextSetRGBStrokeColor(context, _r, _g, _b, _a);
	 
	// draw an ellipse in the provided rectangle
	CGContextAddEllipseInRect(context, _outerCircleRect);
	CGContextStrokePath(context);
	 
	CGContextAddEllipseInRect(context, _innerCircleRect);
	CGContextStrokePath(context);
	 
	CGContextRestoreGState(context);
}

#pragma mark -
#pragma mark Properties

- (void)setProgress:(CGFloat)newProgress 
{
	if (progress != newProgress) {
		progress = newProgress;
		[self setNeedsDisplay:YES];
	}
}

- (void)setColourR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a
{
	_r = r;
	_g = g;
	_b = b;
	_a = a;
	[self setNeedsDisplay: YES];
}

@end