//
//  DeliciousUser.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/25/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// Preference keys.
extern NSString *const DBSyncOnLaunchPrefKey;
extern NSString *const DBUserPrefKey;
extern NSString *const DBPasswordPrefKey;

@interface DeliciousUser : NSObject {
  NSString *username;
  NSString *password;
  NSURL    *website;
  NSURL    *baseURL;

  NSArray *bookmarks;
  NSArray *tags;
}

@property (readonly, assign) NSArray *bookmarks;
@property (readonly, assign) NSArray *tags;
@property (readonly, assign) NSURL   *website;

- (id)initWithUsername:(NSString *)theUsername andPassword:(NSString *)thePassword;

- (BOOL)syncBookmarks;
- (void)fetchBookmarks;
- (void)parseTagsFromBookmarks;

- (NSArray *)sendRequest:(NSString *)request forElement:(NSString *)theElement;

- (IBAction)openBookmark:(NSMenuItem *)menuItem;

@end
