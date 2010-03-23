//
//  DeliciousUser.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "DeliciousUser.h"

@implementation DeliciousUser

@synthesize username;
@synthesize password;
@synthesize baseURL;
@synthesize website;
@synthesize tags;
@synthesize bookmarks;

#pragma mark factory

- (id)init
{
  if (![super init]) {
    [self release];
    return nil;
  }

  // TODO: Load saved bookmarks.
  // TODO: Set lastUpdate time and check before making a request.
  return self;
}

- (id)initWithUsername:(NSString *)theUsername andPassword:(NSString *)thePassword
{
  if (![self init]) {
    [self release];
    return nil;
  }
  
  if (([theUsername length] == 0) || ([thePassword length] == 0)) {
    [self release];
    return nil;
  }
  
  [self setUsername:theUsername];
  [self setPassword:thePassword];

  baseURL = [NSString stringWithFormat:@"https://%@:%@@api.del.icio.us/v1", username, password];
  website = [NSURL URLWithString:[NSString stringWithFormat:@"http://delicious.com/%@", username]];

  return self;
}

- (void)dealloc
{
  [username release];
  [password release];
  [baseURL release];
  [website release];
  [tags release];
  [bookmarks release];
  [super dealloc];
}

#pragma mark accessors

- (NSArray *)bookmarks
{
  if (!bookmarks) [self fetchBookmarks];
  return bookmarks;
}

#pragma mark public

// TODO: Should probably save the bookmarks locally.
- (BOOL)syncBookmarks
{
  [self fetchBookmarks];
  return !!bookmarks;
}

- (void)fetchTags
{
  tags = [[[self sendRequest:@"tags/get"] rootElement] elementsForName:@"tag"];
}

- (void)fetchBookmarks
{
  if (!tags) [self fetchTags];
  bookmarks = [[[self sendRequest:@"posts/all"] rootElement] elementsForName:@"post"];
}

// TODO: Check +request+ for leading '/' and remove if present.
- (NSXMLDocument *)sendRequest:(NSString *)request
{
  NSError *err = nil;

  // DEBUG
  NSURL *requestURL = [NSURL fileURLWithPath:[NSString
                                              stringWithFormat:@"/Users/oshuma/Projects/DeliciousBar/test/%@", request]];
//  NSURL *requestURL = [NSURL URLWithString:[NSString
//                                            stringWithFormat:@"%@/%@", baseURL, request]];
  return [[NSXMLDocument alloc]
          initWithContentsOfURL:requestURL
          options:0
          error:&err];
}

@end
