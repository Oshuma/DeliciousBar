//
//  AppController.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/24/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DeliciousUser;
@class PreferencesController;

@interface AppController : NSObject {
  NSWindow *window;

  IBOutlet NSMenu *mainMenu;
  NSStatusItem *mainMenuItem;

  NSUserDefaults *preferences;
  DeliciousUser *user;

  PreferencesController *prefsController;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSMenu *mainMenu;
@property (readwrite, assign) NSUserDefaults *preferences;
@property (readwrite, assign) DeliciousUser *user;

- (IBAction)syncBookmarks:(id)sender;
- (IBAction)showPreferences:(id)sender;
- (IBAction)browseBookmarks:(id)sender;
- (IBAction)quitApplication:(id)sender;

- (void)loadUserFromPreferences;
- (void)syncOnLaunch;

@end
