//
//  PreferenceController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/20/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "PreferenceController.h"

NSString* const DBSyncOnLaunchKey = @"SyncOnLaunch";
NSString* const DBUserPrefKey     = @"DeliciousUsername";
NSString* const DBPasswordPrefKey = @"DeliciousPassword";

@implementation PreferenceController

#pragma mark factory

- (id)init
{
  if (![super initWithWindowNibName:@"Preferences"]) return nil;
  if (!preferences) preferences = [NSUserDefaults standardUserDefaults];
  return self;
}

#pragma mark UI

- (void)windowDidLoad
{
  [syncOnLaunchCheckbox setState:[preferences boolForKey:DBSyncOnLaunchKey]];
  NSString *username = [preferences objectForKey:DBUserPrefKey];
  NSString *password = [preferences objectForKey:DBPasswordPrefKey];
  if (username) [usernameField setStringValue:username];
  if (password) [passwordField setStringValue:password];
}

- (IBAction)closeWindow:(id)sender
{
  [self close];
}

- (IBAction)savePreferences:(id)sender
{
  NSString *username = [usernameField stringValue];
  NSString *password = [passwordField stringValue];
  [preferences setObject:username forKey:DBUserPrefKey];
  [preferences setObject:password forKey:DBPasswordPrefKey];
  [preferences setBool:[syncOnLaunchCheckbox state] forKey:DBSyncOnLaunchKey];
  [self close];
}

@end
