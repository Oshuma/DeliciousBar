//
//  PreferencesController.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/25/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SharedMenubarController.h"

@interface PreferencesController : SharedMenubarController {
  NSWindow *window;

  NSUserDefaults       *preferences;
  IBOutlet NSTextField *usernameField;
  IBOutlet NSTextField *passwordField;
  IBOutlet NSButton    *syncOnLaunchCheckbox;
}

- (IBAction)closeWindow:(id)sender;
- (IBAction)savePreferences:(id)sender;

@end
