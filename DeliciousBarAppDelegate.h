//
//  DeliciousBarAppDelegate.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/20/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface DeliciousBarAppDelegate : NSObject {
  NSWindow *window;
  PreferenceController *preferenceController;

  IBOutlet NSMenu *statusMenu;
  NSStatusItem *statusItem;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)openWebsite:(id)sender;
- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)quitApplication:(id)sender;

@end
