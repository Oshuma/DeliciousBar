//
//  DeliciousUser.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "DeliciousUser.h"
#import "Tag.h"

// Preference keys.
NSString *const DBSyncOnLaunchKey     = @"SyncOnLaunch";
NSString *const DBUserPrefKey         = @"DeliciousUsername";
NSString *const DBPasswordPrefKey     = @"DeliciousPassword";
NSString *const DeliciousBookmarksKey = @"DeliciousBookmarks";
NSString *const DeliciousTagsKey      = @"DeliciousTags";

@implementation DeliciousUser

@synthesize username;
@synthesize password;
@synthesize baseURL;
@synthesize website;
@synthesize tags;
@synthesize bookmarks;

#pragma mark factory

- (id)init
{
  if (![super init]) {
    [self release];
    return nil;
  }

  // TODO: Load saved bookmarks.
  // TODO: Set lastUpdate time and check before making a request.
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
  
  [self setUsername:theUsername];
  [self setPassword:thePassword];
  website = [NSURL URLWithString:[NSString stringWithFormat:@"http://delicious.com/%@", username]];

#ifdef DEBUG
  baseURL = [NSURL URLWithString:@"http://localhost:4567"];
#else
  baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@:%@@api.del.icio.us/v1",
                                  username, password]];
#endif

  return self;
}

- (void)dealloc
{
  [username release];
  [password release];
  [baseURL release];
  [website release];
  [tags release];
  [bookmarks release];
  [super dealloc];
}

#pragma mark accessors

- (NSArray *)bookmarks
{
  if (!bookmarks) [self fetchBookmarks];
  return bookmarks;
}

#pragma mark sync methods

// Fetch the remote bookmarks and save them locally.
- (BOOL)syncBookmarks
{
  [self fetchBookmarks];
  return !!bookmarks;
}

- (void)fetchBookmarks
{
  if (!tags) [self fetchTags];
  bookmarks = [[[self sendRequest:@"posts/all"] rootElement] elementsForName:@"post"];
  [self saveBookmarks];
}

- (void)saveBookmarks
{
  [[NSUserDefaults standardUserDefaults]
   setObject:[NSArray arrayWithArray:bookmarks]
   forKey:DeliciousBookmarksKey];
}

- (void)fetchTags
{
//  tags = [[[self sendRequest:@"tags/get"] rootElement] elementsForName:@"tag"];
  NSMutableArray *theTags = [NSMutableArray array];
  NSArray *tagElements = [[[self sendRequest:@"tags/get"] rootElement] elementsForName:@"tag"];
  NSEnumerator *iterator = [tagElements objectEnumerator];

  id tag;
  while (tag = [iterator nextObject]) {
    NSString *tagName = [[tag attributeForName:@"tag"] stringValue];
    [theTags addObject:[[Tag alloc] initWithName:tagName]];
    [tagName release];
  }

  tags = [NSArray arrayWithArray:theTags];

  [tag release];
  [iterator release];
  [tagElements release];
  [theTags release];
  [self saveTags];
}

- (void)saveTags
{
  [[NSUserDefaults standardUserDefaults]
   setObject:[NSArray arrayWithArray:tags]
   forKey:DeliciousTagsKey];
}

#pragma mark utility

- (NSArray *)getBookmarksForTag:(NSString *)theTag
{
  NSMutableArray *theBookmarks = [NSMutableArray array];
  NSEnumerator *iterator = [bookmarks objectEnumerator];

  id bookmark;
  while (bookmark = [iterator nextObject]) {
    NSArray *tagNames = [[[bookmark attributeForName:@"tag"]
                          stringValue] componentsSeparatedByString:@" "];
    if ([tagNames containsObject:theTag]) [theBookmarks addObject:bookmark];
    [tagNames release];
  }

  [iterator release];
  return [NSArray arrayWithArray:theBookmarks];
}

- (IBAction)openBookmark:(NSMenuItem *)menuItem
{
  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:
                                          [[[menuItem representedObject]
                                            attributeForName:@"href"] stringValue]]];
}

// TODO: Check +request+ for leading '/' and remove if present.
- (NSXMLDocument *)sendRequest:(NSString *)request
{
  NSError *requestError = nil;

  NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseURL, request]];

  NSXMLDocument *theDoc = [[NSXMLDocument alloc]
                           initWithContentsOfURL:requestURL
                           options:0
                           error:&requestError];

  if (requestError) {
    // FIXME: It pukes here if using the 'Release' build.
    NSLog(@"ERROR: sendRequest: %@/%@", baseURL, request);
    NSLog(@"\t\t %@", requestError);
    [[NSAlert alertWithMessageText:@"Could not process request."
                     defaultButton:@"Well...fuck."
                   alternateButton:nil
                       otherButton:nil
         informativeTextWithFormat:[NSString stringWithFormat:@"%@", requestError]]
     runModal];
  }

  return theDoc;
}

@end
