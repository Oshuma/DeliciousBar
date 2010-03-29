//
//  Bookmark.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/26/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "Bookmark.h"
#import "DeliciousUser.h"

@implementation Bookmark

@synthesize title;
@synthesize url;
@synthesize tags;
@synthesize xmlElement;

#pragma mark class methods

+ (NSArray *)taggedWith:(NSString *)tagName
{
  NSMutableArray *theBookmarks = [[NSMutableArray array] autorelease];
  DeliciousUser *user = (DeliciousUser *)[[NSApp delegate] user];
  NSEnumerator *iterator = [[user bookmarks] objectEnumerator];

  id bookmark;
  while (bookmark = [iterator nextObject]) {
    NSArray *theTags = [[[[bookmark xmlElement] attributeForName:@"tag"]
                         stringValue] componentsSeparatedByString:@" "];
    if ([theTags containsObject:tagName]) [theBookmarks addObject:bookmark];
    [theTags release];
  }

  [iterator release];
  [user release];
  return [NSArray arrayWithArray:theBookmarks];
}

#pragma mark factory

- (id)initWithTitle:(NSString *)theTitle
{
  if (![self init]) {
    [self release];
    return nil;
  }
  title = theTitle;
  return self;
}

- (id)initWithTitle:(NSString *)theTitle andURL:(NSURL *)theURL
{
  if (![self initWithTitle:theTitle]) {
    [self release];
    return nil;
  }
  url = theURL;
  return self;
}

- (id)initWithTitle:(NSString *)theTitle andURL:(NSURL *)theURL withXmlElement:(NSXMLElement *)theElement
{
  if (![self initWithTitle:theTitle andURL:theURL]) {
    [self release];
    return nil;
  }
  xmlElement = theElement;
  return self;
}

- (void)dealloc
{
  [title release];
  [url release];
  [xmlElement release];
  [super dealloc];
}

@end
