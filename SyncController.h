//
//  SyncController.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/26/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SharedMenubarController.h"

@class DeliciousUser;

@interface SyncController : SharedMenubarController {
  NSUserDefaults *preferences;
  DeliciousUser *user;
  IBOutlet NSButton *cancelButton;
  IBOutlet NSProgressIndicator *progressBar;
}

- (IBAction)cancelOrFinish:(id)sender;
- (void)updateTagsMenu;

@end
