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
#import "DeliciousUser.h"

@implementation DeliciousBarAppDelegate

@synthesize window;
@synthesize user;
@synthesize preferences;

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
  if ([user syncBookmarks]) {
    NSLog(@"Sync on launch: OK");
  } else {
    NSLog(@"Sync on launch: FAIL");
  }
  NSLog(@"App launched.");
}

- (void)awakeFromNib
{
  statusItem = [[[NSStatusBar systemStatusBar]
                 statusItemWithLength:NSVariableStatusItemLength] retain];
  [statusItem setMenu:statusMenu];
  // TODO: Can probably set these in Interface Builder.
  [statusItem setTitle:@"Delicious"];
  [statusItem setHighlightMode:YES];
//  [statusItem setImage:imageObject];
//  [statusItem setAlternateImage:otherImageObject];
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

- (IBAction)syncBookmarks:(id)sender
{
  [[[BookmarksController alloc] init] showWindow:self];
}

- (IBAction)quitApplication:(id)sender
{
  [NSApp terminate:self];
}

@end
