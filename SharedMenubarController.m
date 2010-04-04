//
//  SharedMenubarController.m
//  DeliciousBar
//
//  Created by Dale Campbell on 4/4/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "SharedMenubarController.h"


@implementation SharedMenubarController

- (void)awakeFromNib
{
  if ( ! [NSApp isActive] ) [NSApp activateIgnoringOtherApps:YES];
}

@end
