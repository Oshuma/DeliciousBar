//
//  Bookmark.h
//  DeliciousBar
//
//  Created by Dale Campbell on 3/26/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Bookmark : NSObject {
  NSString     *title;
  NSURL        *url;
  NSArray      *tags;
  NSXMLElement *xmlElement;
}

@property (readonly, assign)  NSString     *title;
@property (readonly, assign)  NSURL        *url;
@property (readwrite, assign) NSArray      *tags;
@property (readwrite, assign) NSXMLElement *xmlElement;

- (id)initWithTitle:(NSString *)theTitle;
- (id)initWithTitle:(NSString *)theTitle andURL:(NSURL *)theURL;
- (id)initWithTitle:(NSString *)theTitle andURL:(NSURL *)theURL withXmlElement:(NSXMLElement *)theElement;

@end
