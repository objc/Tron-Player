//
//  AppDelegate.m
//  Tron Player
//
//  Copyright 2011 George L. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@implementation AppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[mainWindowController showWindow:self];
}

@end
