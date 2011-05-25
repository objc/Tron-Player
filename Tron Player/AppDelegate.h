//
//  AppDelegate.h
//  Tron Player
//
//  Copyright 2011 George L. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MainWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
@private
	IBOutlet MainWindowController *mainWindowController;
}

@property (assign) IBOutlet NSWindow *window;

@end
