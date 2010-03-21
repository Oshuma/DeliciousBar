//
//  PreferenceController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/20/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "PreferenceController.h"

NSString *const DeliciousUserKey = @"DeliciousUsername";
NSString *const DeliciousPasswordKey = @"DeliciousPassword";

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
  NSString *password = [preferences objectForKey:DeliciousPasswordKey];
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
  NSLog(@"Saving Username: %@", username);
  NSLog(@"Saving Password: %@", password);
  [preferences setObject:username forKey:DeliciousUserKey];
  [preferences setObject:password forKey:DeliciousPasswordKey];
  [self close];
}

@end
