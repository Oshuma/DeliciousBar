//
//  BookmarksController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "BookmarksController.h"


@implementation BookmarksController

- (id)init
{
  if (![super initWithWindowNibName:@"Bookmarks"]) return nil;
  if (!preferences) preferences = [NSUserDefaults standardUserDefaults];
  return self;
}

- (void)windowDidLoad
{
  NSLog(@"Syncing bookmarks...");
  // DeliciousUser *user = ;[DeliciousUser init] alloc];
  // [user syncBookmarks];
}

- (IBAction)cancelOrFinish:(id)sender
{
  NSLog(@"cancelOrFinish:");
  [self close];
}

@end
