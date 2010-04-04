//
//  PreferencesController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/25/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "PreferencesController.h"
#import "AppController.h"
#import "DeliciousUser.h"

@implementation PreferencesController

#pragma mark factory

- (id)init
{
  if ( ! [super initWithWindowNibName:@"Preferences"] ) return nil;
  if ( ! preferences ) preferences = [NSUserDefaults standardUserDefaults];
  return self;
}

- (void)dealloc
{
  [preferences release];
  [super dealloc];
}

#pragma mark UI

- (void)windowDidLoad
{
  NSString *username = [preferences objectForKey:DBUserPrefKey];
  NSString *password = [preferences objectForKey:DBPasswordPrefKey];
  if (username) [usernameField setStringValue:username];
  if (password) [passwordField setStringValue:password];
  [syncOnLaunchCheckbox setState:[preferences boolForKey:DBSyncOnLaunchPrefKey]];
}

- (IBAction)closeWindow:(id)sender
{
  [self close];
}

- (IBAction)savePreferences:(id)sender
{
  [preferences setObject:[usernameField stringValue] forKey:DBUserPrefKey];
  [preferences setObject:[passwordField stringValue] forKey:DBPasswordPrefKey];
  [preferences setBool:[syncOnLaunchCheckbox state]  forKey:DBSyncOnLaunchPrefKey];
  [preferences synchronize];
  [[NSApp delegate] loadUserFromPreferences];
  [self close];
}

@end
