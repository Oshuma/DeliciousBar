//
//  DeliciousUser.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DeliciousUser : NSObject {
  NSString *username;
  NSString *password;
  NSString *baseURL;
}

@property (readwrite, assign) NSString *username;
@property (readwrite, assign) NSString *password;
@property (readwrite, assign) NSString *baseURL;

- (id)initWithUsername:(NSString *)username;
- (BOOL)syncBookmarks;

@end
