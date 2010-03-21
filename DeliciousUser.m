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

- (BOOL)syncBookmarks
{
  NSLog(@"%@:%@: syncBookmarks", self, username);
  return true;
}

@end
