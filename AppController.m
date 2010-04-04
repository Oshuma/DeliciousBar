//
//  AppController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/24/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "AppController.h"
#import "DeliciousUser.h"
#import "PreferencesController.h"
#import "SyncController.h"

@implementation AppController

@synthesize window;
@synthesize mainMenu;
@synthesize preferences;
@synthesize user;

#pragma mark factory

- (id)init
{
  if ( ! [super init] ) {
    [self release];
    return nil;
  }

  if ( ! preferences ) preferences = [NSUserDefaults standardUserDefaults];
  return self;
}

- (void)dealloc
{
  [preferences release];
  [user release];
  [super dealloc];
}

#pragma mark delegates

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [self loadUserFromPreferences];
  [self syncOnLaunch];
  NSLog(@"App launched.");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
  NSLog(@"applicationWillTerminate:");
}

#pragma mark UI

- (void)awakeFromNib
{
  mainMenuItem = [[[NSStatusBar systemStatusBar]
                   statusItemWithLength:NSVariableStatusItemLength] retain];
  [mainMenuItem setMenu:mainMenu];
  [mainMenuItem setHighlightMode:YES];
  NSString *icon = [[NSBundle mainBundle] pathForResource:@"menuIcon" ofType:@"gif"];
  [mainMenuItem setImage:[[NSImage alloc] initWithContentsOfFile:icon]];
}

- (IBAction)syncBookmarks:(id)sender
{
  [[[SyncController alloc] init] showWindow:nil];
}

- (IBAction)showPreferences:(id)sender
{
  [[[PreferencesController alloc] init] showWindow:nil];
}

- (IBAction)browseBookmarks:(id)sender
{
  [[NSWorkspace sharedWorkspace] openURL:[user website]];
}

- (IBAction)quitApplication:(id)sender
{
  [NSApp terminate:self];
}

#pragma mark private

- (void)loadUserFromPreferences
{
  NSLog(@"AppController -loadUserFromPreferences");
  NSString *username = [preferences stringForKey:DBUserPrefKey];
  NSString *password = [preferences stringForKey:DBPasswordPrefKey];
  if ( ([username length] != 0) && ([password length] != 0) ) {
    user = [[DeliciousUser alloc] initWithUsername:username andPassword:password];
    [username release];
    [password release];
  } else {
    // TODO: Show an alert of why it failed.
    [self showPreferences:self];
    user = nil;
  }
}

- (void)syncOnLaunch
{
  if ( [preferences boolForKey:DBSyncOnLaunchPrefKey] ) {
    if ( [user syncBookmarks] ) {
      [[[SyncController alloc] init] updateTagsMenu];
    } else {
      NSLog(@"Sync on launch failed.");
    }
  }
}

@end
