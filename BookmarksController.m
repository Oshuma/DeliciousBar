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

  NSString *username = [preferences objectForKey:DeliciousUserKey];
  NSString *password = [preferences objectForKey:DeliciousPasswordKey];
  user = [[DeliciousUser alloc] initWithUsername:username];
  [user setPassword:password];
  
  return self;
}

- (void)windowDidLoad
{
  if ([user syncBookmarks]) {
    NSLog(@"%@: sync success", self);
  } else {
    NSLog(@"%@: sync failed", self);
  }
}

- (IBAction)cancelOrFinish:(id)sender
{
  NSLog(@"cancelOrFinish:");
  [preferences release];
  [user release];
  [self close];
}

@end
