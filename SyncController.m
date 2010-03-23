//
//  SyncController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "SyncController.h"
#import "DeliciousUser.h"

@implementation SyncController

#pragma mark factory

- (id)init
{
  if (![super initWithWindowNibName:@"Sync"]) return nil;
  if (!preferences) preferences = [NSUserDefaults standardUserDefaults];
  return self;
}

#pragma mark UI

- (void)windowWillLoad
{
  user = [self getDeliciousUser];
}

- (void)windowDidLoad
{
  [progressBar startAnimation:self];
  if ([user syncBookmarks]) {
    [self updateTagsMenu];
    // TODO: Set a timeout until the window closes itself.
    [cancelButton setTitle:@"Finished"];
  } else {
    // TODO: Maybe an NSAlert here.
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
    NSString *tagName = [[[[user tags] objectAtIndex:i] attributeForName:@"tag"] stringValue];
    NSMenuItem *tagItem = [[NSMenuItem alloc]
                           initWithTitle:tagName
                           action:nil
                           keyEquivalent:@""];

    // TODO: Add submenu for each tag (containing the tags bookmarks).
    [tagsMenu addItem:tagItem];

    [tagItem release];
    [tagName release];
  }

  [tagsMenu release];
}

#pragma mark utility

- (DeliciousUser *)getDeliciousUser
{
  return (DeliciousUser *)[[NSApp delegate] user];
}

@end
