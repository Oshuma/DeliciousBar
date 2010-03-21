//
//  PreferenceController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/20/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "PreferenceController.h"

NSString *const DeliciousUserKey = @"DeliciousUsername";

@implementation PreferenceController

- (id)init
{
  if (![super initWithWindowNibName:@"Preferences"]) return nil;
  if (!preferences) preferences = [NSUserDefaults standardUserDefaults];
  return self;
}

- (void)windowDidLoad
{
  NSString *username = [preferences objectForKey:DeliciousUserKey];
  if (username) [usernameField setStringValue:username];
  NSLog(@"Preferences nib loaded.");
}

- (IBAction)closeWindow:(id)sender
{
  NSLog(@"Closing prefs window.");
  [self close];
}

- (IBAction)savePreferences:(id)sender
{
  NSString *username = [usernameField stringValue];
  NSLog(@"Saving Username: %@", username);
  [preferences setObject:username forKey:DeliciousUserKey];
  [self close];
}

@end
