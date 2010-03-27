//
//  SyncController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/26/10.
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
  if (!user) user = (DeliciousUser *)[[NSApp delegate] user];
  return self;
}

- (void)dealloc
{
  [preferences dealloc];
  [user dealloc];
  [super dealloc];
}

#pragma mark UI

- (void)windowDidLoad
{
  NSLog(@"SyncController windowDidLoad:");
}

- (IBAction)cancelOrFinish:(id)sender
{
  NSLog(@"SyncController cancelOrFinish:");
}

- (void)updateTagsMenu
{
  NSLog(@"SyncController updateTagsMenu:");
  NSMenu *tagsMenu = [[[[NSApp delegate] mainMenu] itemWithTitle:@"Tags"] submenu];

  for (int i = 0; i < [[user tags] count]; i++) {
    NSLog(@"TAG: %@", [[user tags] objectAtIndex:i]);
  }
}

@end
