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
  
  // FIXME: This should be accessed from the delegate user instead of creating a new instance.
  user = [[DeliciousUser alloc]
          initWithUsername:[preferences objectForKey:DBUserPrefKey]
          andPassword:[preferences objectForKey:DBPasswordPrefKey]];

  return self;
}

#pragma mark UI

- (void)windowDidLoad
{
  [progressBar startAnimation:self];
  if ([user syncBookmarks]) {
    [self updateTagsMenu];
    [cancelButton setTitle:@"Finished"];
  } else {
    // TODO: Maybe an alert here.
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
  NSMenu *tagsMenu = [[[[NSApp delegate] mainMenu] itemWithTitle:@"Tags"] submenu];

  for(int i = 0; i < [[user tags] count]; i++) {
    NSString *tagName = [[[[user tags] objectAtIndex:i] attributeForName:@"tag"] stringValue];
    NSMenuItem *tagItem = [[NSMenuItem alloc]
                           initWithTitle:tagName
                           action:nil
                           keyEquivalent:@""];

    [tagsMenu addItem:tagItem];

    [tagItem release];
    [tagName release];
  }

  [tagsMenu release];
}

@end
