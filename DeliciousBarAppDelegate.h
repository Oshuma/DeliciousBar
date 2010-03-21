//
//  DeliciousBarAppDelegate.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/20/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DeliciousUser;

@interface DeliciousBarAppDelegate : NSObject {
  NSWindow *window;

  IBOutlet NSMenu *statusMenu;
  NSStatusItem *statusItem;

  NSUserDefaults *preferences;
  DeliciousUser *user;
}

@property (assign) IBOutlet NSWindow *window;
@property (readwrite, assign) NSUserDefaults *preferences;
@property (readwrite, assign) DeliciousUser *user;

- (IBAction)openWebsite:(id)sender;
- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)syncBookmarks:(id)sender;
- (IBAction)quitApplication:(id)sender;

@end
