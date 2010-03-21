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

@implementation DeliciousBarAppDelegate

@synthesize window;

+ (void)initialize
{
  // Setup defaults here:
//  NSMutableDictionary *preferences = [NSMutableDictionary dictionary];
//  [preferences setObject:@"Oshuma" forKey:DeliciousUserKey];
//  
//  // Register the defaults.
//  [[NSUserDefaults standardUserDefaults] registerDefaults:preferences];
//  NSLog(@"Preferences loaded: %@", preferences);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
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
}

- (IBAction)openWebsite:(id)sender
{
  // TODO: Move this to DeliciousUser.
  NSString *username = [[NSUserDefaults standardUserDefaults]
                        objectForKey:DeliciousUserKey];
  if (username && ([username length] != 0)) {
    NSURL *url = [NSURL URLWithString:
                 [NSString stringWithFormat:@"http://delicious.com/%@", username]];
    [[NSWorkspace sharedWorkspace] openURL:url];
    [username release];
  } else {
    NSLog(@"Username not set; switching to prefs panel.");
    [self showPreferencePanel:self];
  }
}

// FIXME: Sometimes it doesn't focus the window.
- (IBAction)showPreferencePanel:(id)sender
{
  if (!preferences) {
    preferences = [[PreferenceController alloc] init];
  }
  [preferences showWindow:self];
}

- (IBAction)syncBookmarks:(id)sender
{
  if (!bookmarks) {
    bookmarks = [[BookmarksController alloc] init];
  }
  [bookmarks showWindow:self];
}

- (IBAction)quitApplication:(id)sender
{
  [NSApp terminate:self];
}

@end
