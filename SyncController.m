//
//  SyncController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "SyncController.h"
#import "DeliciousUser.h"
#import "Tag.h"

@implementation SyncController

#pragma mark factory

- (id)init
{
  if (![super initWithWindowNibName:@"Sync"]) return nil;
  if (!preferences) preferences = [NSUserDefaults standardUserDefaults];
  user = [self getDeliciousUser];
  return self;
}

#pragma mark UI

- (void)windowDidLoad
{
  [progressBar startAnimation:self];
  if ([user syncBookmarks]) {
    [self updateTagsMenu];
    // TODO: Set a timeout until the window closes itself.
    [cancelButton setTitle:@"Finished"];
  } else {
    // FIXME: Weird things happen here.  The Bookmarks nib gets loaded for some reason.
//    [[NSAlert alertWithMessageText:@"Sync failed."
//                     defaultButton:@"Aww..."
//                   alternateButton:nil
//                       otherButton:nil
//         informativeTextWithFormat:nil]
//     runModal];
    [cancelButton setTitle:@"Failed"];
  }
  [progressBar stopAnimation:self];
}

- (IBAction)cancelOrFinish:(id)sender
{
  [progressBar stopAnimation:self];
  [preferences release];
  [user release];
  [self close];
}

- (void)updateTagsMenu
{
  // Setup the user if not being called from a nib.
  if (!user) user = [self getDeliciousUser];

  NSMenu *tagsMenu = [[[[NSApp delegate] mainMenu] itemWithTitle:@"Tags"] submenu];

  for(int i = 0; i < [[user tags] count]; i++) {
//    NSString *tagName = [[[[user tags] objectAtIndex:i] attributeForName:@"tag"] stringValue];
    Tag *tag = [[user tags] objectAtIndex:i];
    NSMenuItem *tagItem = [[NSMenuItem alloc]
                           initWithTitle:[tag name]
                           action:nil
                           keyEquivalent:@""];

    NSMenu *tagSubmenu = [[NSMenu alloc] initWithTitle:[tag name]];
//    NSArray *posts = [user getBookmarksForTag:tagName];
    NSArray *posts = [tag bookmarks];
    NSEnumerator *iterator = [posts objectEnumerator];

    id post;
    while (post = [iterator nextObject]) {
      NSMenuItem *postItem = [[NSMenuItem alloc]
                              initWithTitle:[[post attributeForName:@"description"] stringValue]
                              action:nil
                              keyEquivalent:@""];

      [postItem setTarget:user];
      [postItem setAction:@selector(openBookmark:)];
      [postItem setRepresentedObject:post];
      [postItem setToolTip:[[post attributeForName:@"href"] stringValue]];

      [tagSubmenu addItem:postItem];
      [postItem release];
    }

    [tagItem setSubmenu:tagSubmenu];
    [tagsMenu addItem:tagItem];

    [iterator release];
    [posts release];
    [tagSubmenu release];
    [tagItem release];
    [tag release];
  }

  [tagsMenu release];
}

#pragma mark utility

- (DeliciousUser *)getDeliciousUser
{
  return (DeliciousUser *)[[NSApp delegate] user];
}

@end
