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

- (id)initWithUsername:(NSString *)newUsername
{
  if (![super init]) {
    [self release];
    return nil;
  }

  if ([newUsername length] == 0) {
    [self release];
    return nil;
  }
  
  [self setUsername:newUsername];
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
  NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.del.icio.us/v1/tags/get",
                         username, password];
  NSURL *url = [NSURL URLWithString:urlString];
  NSError *err = nil;
//  NSXMLDocument *tags = [[NSXMLDocument alloc]
//                         initWithXMLString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><tags><tag>awesome</tag></tags>"
//                         options:0
//                         error:&err];
  NSXMLDocument *tags = [[NSXMLDocument alloc]
                         initWithContentsOfURL:url
                         options:0
                         error:&err];
  NSLog(@"TAGS: %@", tags);
  return true;
}

@end
