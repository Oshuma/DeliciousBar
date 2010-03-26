//
//  DeliciousUser.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/25/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "DeliciousUser.h"
#import "Bookmark.h"

// Preference keys.
NSString *const DBSyncOnLaunchPrefKey = @"DeliciousSyncOnLaunch";
NSString *const DBUserPrefKey         = @"DeliciousUsername";
NSString *const DBPasswordPrefKey     = @"DeliciousPassword";

@implementation DeliciousUser

@synthesize bookmarks;
@synthesize website;

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

  username = theUsername;
  password = thePassword;
  website  = [NSURL URLWithString:[NSString stringWithFormat:@"http://delicious.com/%@", username]];

#ifdef DEBUG
  baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@@localhost:4567",
                                  username, password]];
#else
  baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@:%@@api.del.icio.us/v1",
                                  username, password]];
#endif

  return self;
}

- (BOOL)syncBookmarks
{
  NSLog(@"DeliciousUser syncBookmarks:");
  [self fetchBookmarks];
  return !!bookmarks;
}

- (void)fetchBookmarks
{
  NSLog(@"DeliciousUser fetchBookmarks:");
  NSArray *posts = [self sendRequest:@"posts/all" forElement:@"post"];
  NSMutableArray *theBookmarks = [NSMutableArray array];
  NSEnumerator *iterator = [posts objectEnumerator];

  id post;
  while (post = [iterator nextObject]) {
    Bookmark *newBookmark = [[Bookmark alloc]
                             initWithTitle:[[post attributeForName:@"description"] stringValue]
                             andURL:[NSURL URLWithString:[[post attributeForName:@"href"] stringValue]]];
    [theBookmarks addObject:newBookmark];
    [newBookmark release];
  }

  bookmarks = [NSArray arrayWithArray:theBookmarks];

  [iterator release];
  [theBookmarks release];
  [posts release];
}

- (NSArray *)sendRequest:(NSString *)request forElement:(NSString *)theElement
{
  NSError *requestError = nil;
  NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseURL, request]];

  NSArray *response = [[[[NSXMLDocument alloc]
                         initWithContentsOfURL:requestURL options:0 error:&requestError]
                        rootElement] elementsForName:theElement];

  if (requestError) {
    // TODO: Proper error handling.
    NSLog(@"\t request error: %@", requestError);
    return nil;
  }

  return response;
}

@end
