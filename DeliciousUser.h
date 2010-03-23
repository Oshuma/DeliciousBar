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
  NSArray  *tags;
  NSArray  *bookmarks;
}

@property (readwrite, assign) NSString *username;
@property (readwrite, assign) NSString *password;
@property (readonly, assign)  NSString *baseURL;
@property (readonly, assign)  NSURL    *website;
@property (readwrite, assign) NSArray  *tags;
@property (readonly, assign) NSArray  *bookmarks;

- (id)initWithUsername:(NSString *)theUsername andPassword:(NSString *)thePassword;

- (BOOL)syncBookmarks;
- (void)fetchTags;
- (void)fetchBookmarks;
- (NSXMLDocument *)sendRequest:(NSString *)request;

@end
