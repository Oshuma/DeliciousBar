//
//  BookmarksController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/22/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "BookmarksController.h"


@implementation BookmarksController

#pragma mark factory

- (id)init
{
  if (![super initWithWindowNibName:@"Bookmarks"]) return nil;
  return self;
}

#pragma mark UI

- (void)windowDidLoad
{
  // load the tags
  NSLog(@"TAGS: %@", tagBrowser);
}

@end
