//
//  Tag.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/24/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "Tag.h"

@implementation Tag

@synthesize name;
@synthesize bookmarks;

- (void)dealloc
{
  [name release];
  [bookmarks release];
  [super dealloc];
}

- (id)initWithName:(NSString *)tagName
{
  if (![self init]) {
    [self release];
    return nil;
  }
  
  name = tagName;
  return self;
}

- (id)initWithName:(NSString *)tagName andBookmarks:(NSArray *)theBookmarks
{
  if (![self initWithName:tagName]) {
    [self release];
    return nil;
  }
  
  bookmarks = theBookmarks;
  return self;
}

@end
