//
//  Bookmark.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/26/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "Bookmark.h"


@implementation Bookmark

@synthesize title;
@synthesize url;
@synthesize tags;
@synthesize xmlElement;

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

@end
