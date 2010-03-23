//
//  SyncController.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DeliciousUser;

extern NSString *const DBUserPrefKey;
extern NSString *const DBPasswordPrefKey;

@interface SyncController : NSWindowController {
  IBOutlet NSButton* cancelButton;
  IBOutlet NSProgressIndicator* progressBar;

  NSUserDefaults* preferences;
  DeliciousUser* user;
}

- (IBAction)cancelOrFinish:(id)sender;
- (void)updateTagsMenu;

@end