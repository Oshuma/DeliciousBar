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

  baseURL = [NSString stringWithFormat:@"https://%@:%@@api.del.icio.us/v1",
             username, password];
  website = [NSURL URLWithString:
             [NSString stringWithFormat:@"http://delicious.com/%@", username]];

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

#pragma mark public

- (BOOL)syncBookmarks
{
  [self fetchTags];
  [self fetchBookmarks];
  return true;
}

- (void)fetchTags
{
//  [self sendRequest:@"/tags/get"];
  NSError *err = nil;

  // DEBUG
  NSURL *tagsURL = [NSURL fileURLWithPath:@"/Users/oshuma/Projects/DeliciousBar/doc/tags.xml"];
  
//    NSURL *tagsURL = [NSURL URLWithString:[NSString
//                                           stringWithFormat:@"%@/tags/get", baseURL]];
  
  NSXMLDocument *tagsDoc = [[NSXMLDocument alloc]
                            initWithContentsOfURL:tagsURL
                            options:0
                            error:&err];

  tags = [[tagsDoc rootElement] elementsForName:@"tag"];
}

- (void)fetchBookmarks
{
  if (!tags) [self fetchTags];
//  [self sendRequest:@"/posts/all"];
  NSError *err = nil;
  
  // DEBUG
  NSURL *postsURL = [NSURL fileURLWithPath:@"/Users/oshuma/Projects/DeliciousBar/doc/posts_all.xml"];

//  NSURL *postsURL = [NSURL URLWithString:[NSString
//                                          stringWithFormat:@"%@/posts/all", baseURL]];

  NSXMLDocument *posts = [[NSXMLDocument alloc]
                          initWithContentsOfURL:postsURL
                          options:0
                          error:&err];
}

@end
