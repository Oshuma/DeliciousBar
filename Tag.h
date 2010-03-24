//
//  Tag.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/24/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Tag : NSObject {
  NSString  *name;
  NSArray   *bookmarks;
}

@property (readwrite, assign) NSString  *name;
@property (readwrite, assign) NSArray   *bookmarks;

- (id)initWithName:(NSString *)tagName;
- (id)initWithName:(NSString *)tagName andBookmarks:(NSArray *)theBookmarks;

@end
