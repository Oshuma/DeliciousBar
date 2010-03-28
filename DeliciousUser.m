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
@synthesize tags;
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

- (void)dealloc
{
  [username dealloc];
  [password dealloc];
  [website dealloc];
  [baseURL dealloc];
  [bookmarks dealloc];
  [tags dealloc];
  [super dealloc];
}

#pragma mark sync methods

- (BOOL)syncBookmarks
{
  NSLog(@"DeliciousUser syncBookmarks:");
  [self fetchBookmarks];
  [self parseTagsFromBookmarks];
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
                             andURL:[NSURL URLWithString:[[post attributeForName:@"href"] stringValue]]
                             withXmlElement:post];
    [theBookmarks addObject:newBookmark];
    [newBookmark release];
  }

  bookmarks = [NSArray arrayWithArray:theBookmarks];

  [iterator release];
  [theBookmarks release];
  [posts release];
}

- (void)parseTagsFromBookmarks
{
  NSLog(@"DeliciousUser parseTagsFromBookmarks:");
  NSMutableArray *theTags = [NSMutableArray array];
  NSEnumerator *iterator = [bookmarks objectEnumerator];

  id bookmark;
  while (bookmark = [iterator nextObject]) {
    NSArray *tagNames = [[[[bookmark xmlElement] attributeForName:@"tag"]
                          stringValue] componentsSeparatedByString:@" "];

    for (int i = 0; i < [tagNames count]; i++) {
      if (![theTags containsObject:[tagNames objectAtIndex:i]]) {
        [theTags addObject:[tagNames objectAtIndex:i]];
      }
    }
  }

  tags = [theTags sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

  [iterator release];
  [theTags release];
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

- (IBAction)openBookmark:(NSMenuItem *)menuItem
{
  [[NSWorkspace sharedWorkspace] openURL:[[menuItem representedObject] url]];
}

@end
