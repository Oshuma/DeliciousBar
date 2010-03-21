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

  user = [[DeliciousUser init] alloc];
  [user setUsername:@"Oshuma"];
  [user setPassword:@"b0ng"];

  return self;
}

- (void)windowDidLoad
{
  NSLog(@"%@: windowDidLoad:", self);
  [user syncBookmarks];
}

- (IBAction)cancelOrFinish:(id)sender
{
  NSLog(@"cancelOrFinish:");
  [self close];
}

@end
