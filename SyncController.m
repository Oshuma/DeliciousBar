//
//  SyncController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/26/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "SyncController.h"
#import "Bookmark.h"
#import "DeliciousUser.h"

@implementation SyncController

#pragma mark factory

- (id)init
{
  if (![super initWithWindowNibName:@"Sync"]) return nil;
  if (!preferences) preferences = [NSUserDefaults standardUserDefaults];
  if (!user) user = (DeliciousUser *)[[NSApp delegate] user];
  return self;
}

- (void)dealloc
{
  [preferences release];
  [user release];
  [super dealloc];
}

#pragma mark UI

- (void)windowDidLoad
{
  [progressBar startAnimation:self];
  // FIXME: The [user syncBookmarks] call should drop to the background and not tie up the UI.
  if ([user syncBookmarks]) {
    [self updateTagsMenu];
    // TODO: Set timeout until window closes itself.
    [cancelButton setTitle:@"Finish"];
  } else {
    [cancelButton setTitle:@"Failed"];
  }
  [progressBar stopAnimation:self];
}

- (IBAction)cancelOrFinish:(id)sender
{
  [progressBar stopAnimation:sender];
  [self close];
}

- (void)updateTagsMenu
{
  NSLog(@"SyncController -updateTagsMenu:");
  NSMenu *tagsMenu = [[[[NSApp delegate] mainMenu] itemWithTitle:@"Tags"] submenu];

  for(int i = 0; i < [[user tags] count]; i++) {
    NSString *tag = [[user tags] objectAtIndex:i];
    NSMenuItem *tagItem = [[NSMenuItem alloc]
                           initWithTitle:tag
                           action:nil
                           keyEquivalent:@""];

    NSMenu *tagSubmenu = [[NSMenu alloc] initWithTitle:tag];
    NSEnumerator *bookmarkIterator = [[Bookmark taggedWith:tag] objectEnumerator];

    id bookmark;
    while (bookmark = [bookmarkIterator nextObject]) {
      NSMenuItem *bookmarkItem = [[NSMenuItem alloc]
                                  initWithTitle:[bookmark title]
                                  action:nil
                                  keyEquivalent:@""];

      [bookmarkItem setTarget:user];
      [bookmarkItem setAction:@selector(openBookmark:)];
      [bookmarkItem setRepresentedObject:bookmark];
      [bookmarkItem setToolTip:[[bookmark url] absoluteString]];

      [tagSubmenu addItem:bookmarkItem];
      [bookmarkItem release];
    }

    [tagItem setSubmenu:tagSubmenu];
    [tagsMenu addItem:tagItem];

    [bookmarkIterator release];
    [tagSubmenu release];
    [tagItem release];
    [tag release];
  }

  [tagsMenu release];
}

@end
