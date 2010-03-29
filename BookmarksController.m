//
//  BookmarksController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/28/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "BookmarksController.h"
#import "DeliciousUser.h"

@implementation BookmarksController

#pragma mark factory

- (id)init
{
  if (![super initWithWindowNibName:@"Bookmarks"]) return nil;
  user = (DeliciousUser *)[[NSApp delegate] user];
  return self;
}

- (void)dealloc
{
  [user release];
  [super dealloc];
}

@end
