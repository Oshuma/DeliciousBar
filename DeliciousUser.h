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
  NSURL    *website;
  NSXMLDocument *tags;
}

@property (readwrite, assign) NSString *username;
@property (readwrite, assign) NSString *password;
@property (readonly, assign)  NSString *baseURL;
@property (readonly, assign)  NSURL    *website;
@property (readwrite, assign) NSXMLDocument *tags;

- (id)initWithUsername:(NSString *)theUsername andPassword:(NSString *)thePassword;
- (BOOL)syncBookmarks;
- (void)fetchTags;

@end
