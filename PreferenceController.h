//
//  PreferenceController.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/20/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *const DeliciousUserKey;

@interface PreferenceController : NSWindowController {
  NSUserDefaults *preferences;
  IBOutlet NSTextField *usernameField;
}

- (IBAction)closeWindow:(id)sender;
- (IBAction)savePreferences:(id)sender;

@end
