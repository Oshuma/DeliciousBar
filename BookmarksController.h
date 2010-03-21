//
//  BookmarksController.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DeliciousUser;

extern NSString *const DeliciousUserKey;
extern NSString *const DeliciousPasswordKey;

@interface BookmarksController : NSWindowController {
  IBOutlet NSButton *cancelButton;
  IBOutlet NSProgressIndicator *progressBar;
  
  NSUserDefaults *preferences;
  DeliciousUser *user;
}

- (IBAction)cancelOrFinish:(id)sender;

@end
