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
  [super dealloc];
}

- (BOOL)syncBookmarks
{
  [self fetchTags];
  return true;
}

- (void)fetchTags
{
  NSError *err = nil;
  // DEBUG
  NSURL *tagsURL = [NSURL fileURLWithPath:@"/Users/oshuma/Projects/DeliciousBar/doc/tags.xml"];
  
  //  NSURL *tagsURL = [NSURL URLWithString:[NSString
  //                                         stringWithFormat:@"%@/tags/get", baseURL]];
  
  tags = [[NSXMLDocument alloc]
          initWithContentsOfURL:tagsURL
          options:0
          error:&err];
  NSLog(@"URL: %@", tagsURL);
}

@end
