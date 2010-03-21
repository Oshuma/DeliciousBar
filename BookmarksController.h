//
//  BookmarksController.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *const DeliciousUserKey;

@interface BookmarksController : NSWindowController {
  NSUserDefaults *preferences;
}

- (IBAction)cancelOrFinish:(id)sender;

@end
