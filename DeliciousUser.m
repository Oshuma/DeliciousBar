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
  [self setBaseURL:[NSString stringWithFormat:@"https://%@:%@@api.del.icio.us/v1",
                    username, password]];
  return self;
}

- (void)dealloc
{
  [username release];
  [password release];
  [baseURL release];
  [super dealloc];
}

- (BOOL)syncBookmarks
{
  NSError *err = nil;
  NSURL *url = [NSURL URLWithString:[NSString
                                     stringWithFormat:@"%@/tags/get", baseURL]];

  NSXMLDocument *tags = [[NSXMLDocument alloc]
                         initWithXMLString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><tags><tag count=\"4\">awesome</tag><tag count=\"20\">weed</tag></tags>"
                         options:0
                         error:&err];
//  NSXMLDocument *tags = [[NSXMLDocument alloc]
//                         initWithContentsOfURL:url
//                         options:0
//                         error:&err];
  NSLog(@"URL: %@", url);
  NSLog(@"TAGS: %@", tags);
  return true;
}

@end
