//
//  BookmarksController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "BookmarksController.h"
#import "DeliciousUser.h"

@implementation BookmarksController

- (id)init
{
  if (![super initWithWindowNibName:@"Bookmarks"]) return nil;
  if (!preferences) preferences = [NSUserDefaults standardUserDefaults];

  user = [[DeliciousUser alloc]
          initWithUsername:[preferences objectForKey:DeliciousUserKey]
          andPassword:[preferences objectForKey:DeliciousPasswordKey]];

  return self;
}

- (void)windowDidLoad
{
  [progressBar startAnimation:self];
  if ([user syncBookmarks]) {
    NSLog(@"%@: SYNC OK", self);
    [cancelButton setTitle:@"Finished"];
  } else {
    NSLog(@"%@: SYNC FAIL", self);
    // TODO: Maybe an alert here.
    [cancelButton setTitle:@"Failed"];
  }
  [progressBar stopAnimation:self];
}

- (IBAction)cancelOrFinish:(id)sender
{
  NSLog(@"cancelOrFinish:");
  [progressBar stopAnimation:self];
  [preferences release];
  [user release];
  [self close];
}

@end
