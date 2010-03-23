//
//  DeliciousBarAppDelegate.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/20/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "DeliciousBarAppDelegate.h"
#import "PreferenceController.h"
#import "BookmarksController.h"
#import "SyncController.h"
#import "DeliciousUser.h"

@implementation DeliciousBarAppDelegate

@synthesize window;
@synthesize mainMenu;
@synthesize user;
@synthesize preferences;

#pragma mark factory

- (id)init
{
  if (![super init]) {
    [self release];
    return nil;
  }

  if (!preferences) preferences = [NSUserDefaults standardUserDefaults];
  user = [[DeliciousUser alloc]
          initWithUsername:[preferences objectForKey:DBUserPrefKey]
          andPassword:[preferences objectForKey:DBPasswordPrefKey]];

  syncController = [[SyncController alloc] init];

  return self;
}

- (void)dealloc
{
  [preferences release];
  [user release];
  [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  if ([preferences boolForKey:DBSyncOnLaunchKey]) {
    if ([user syncBookmarks]) {
      // TODO: Update Tags menu.
      [syncController updateTagsMenu];
    } else {
      NSLog(@"Sync on launch: FAIL");
    }
  }
  NSLog(@"App launched.");
}

#pragma mark UI

- (void)awakeFromNib
{
  mainMenuItem = [[[NSStatusBar systemStatusBar]
                   statusItemWithLength:NSVariableStatusItemLength] retain];
  [mainMenuItem setMenu:mainMenu];
  // TODO: Can probably set these in Interface Builder.
  [mainMenuItem setTitle:@"Delicious"];
  [mainMenuItem setHighlightMode:YES];

  // TODO: Icon instead of text.
//  [mainMenuItem setImage:imageObject];
//  [mainMenuItem setAlternateImage:otherImageObject];
}

- (IBAction)openWebsite:(id)sender
{
  if (user) {
    [[NSWorkspace sharedWorkspace] openURL:[user website]];
  } else {
    NSLog(@"Username not set; switching to prefs panel.");
    [self showPreferencePanel:self];
  }
}

- (IBAction)showPreferencePanel:(id)sender
{
  [[[PreferenceController alloc] init] showWindow:self];
}

- (IBAction)browseBookmarks:(id)sender
{
  if (!bookmarksController) bookmarksController = [[BookmarksController alloc] init];
  [bookmarksController showWindow:self];
}

- (IBAction)syncBookmarks:(id)sender
{
  if (!syncController) syncController = [[SyncController alloc] init];
  [syncController showWindow:self];
}

- (IBAction)quitApplication:(id)sender
{
  [NSApp terminate:self];
}

@end
