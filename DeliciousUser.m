//
//  DeliciousUser.m
//  DeliciousBar
//
//  Created by Dale Campbell on 3/21/10.
//  Copyright 2010 WTFPL. All rights reserved.
//

#import "DeliciousUser.h"

@implementation DeliciousUser

@synthesize username;
@synthesize password;
@synthesize baseURL;
@synthesize website;
@synthesize tags;

- (id)initWithUsername:(NSString *)theUsername andPassword:(NSString *)thePassword
{
  if (![self init]) {
    [self release];
    return nil;
  }
  
  if (([theUsername length] == 0) || ([thePassword length] == 0)) {
    [self release];
    return nil;
  }
  
  [self setUsername:theUsername];
  [self setPassword:thePassword];

  baseURL = [NSString stringWithFormat:@"https://%@:%@@api.del.icio.us/v1",
             username, password];
  website = [NSURL URLWithString:
             [NSString stringWithFormat:@"http://delicious.com/%@", username]];

  return self;
}

- (void)dealloc
{
  [username release];
  [password release];
  [baseURL release];
  [website release];
  [super dealloc];
}

- (BOOL)syncBookmarks
{
  [self fetchTags];
  return true;
}

- (void)fetchTags
{
  NSError *err = nil;
  NSURL *tagsURL = [NSURL URLWithString:[NSString
                                         stringWithFormat:@"%@/tags/get", baseURL]];
  tags = [[NSXMLDocument alloc]
          initWithXMLString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><tags><tag count=\"19\" tag=\"api\"></tag><tag count=\"4\" tag=\"appengine\"></tag><tag count=\"3\" tag=\"bittorrent\"></tag><tag count=\"11\" tag=\"books\"></tag><tag count=\"6\" tag=\"catalyst\"></tag><tag count=\"9\" tag=\"cheatsheet\"></tag><tag count=\"1\" tag=\"cobalt\"></tag><tag count=\"10\" tag=\"cocoa\"></tag><tag count=\"6\" tag=\"comics\"></tag><tag count=\"11\" tag=\"css\"></tag><tag count=\"4\" tag=\"database\"></tag><tag count=\"140\" tag=\"development\"></tag><tag count=\"3\" tag=\"distributed\"></tag><tag count=\"2\" tag=\"django\"></tag><tag count=\"50\" tag=\"documentation\"></tag><tag count=\"3\" tag=\"faqs\"></tag><tag count=\"6\" tag=\"firefox\"></tag><tag count=\"2\" tag=\"for:4braham\"></tag><tag count=\"1\" tag=\"for:mattgauger\"></tag><tag count=\"2\" tag=\"freelance\"></tag><tag count=\"4\" tag=\"funny\"></tag><tag count=\"8\" tag=\"gamedev\"></tag><tag count=\"14\" tag=\"games\"></tag><tag count=\"8\" tag=\"git\"></tag><tag count=\"5\" tag=\"googlewave\"></tag><tag count=\"3\" tag=\"guildwars\"></tag><tag count=\"3\" tag=\"html5\"></tag><tag count=\"1\" tag=\"icons\"></tag><tag count=\"4\" tag=\"iphone\"></tag><tag count=\"7\" tag=\"java\"></tag><tag count=\"20\" tag=\"javascript\"></tag><tag count=\"2\" tag=\"jobs\"></tag><tag count=\"2\" tag=\"jquery\"></tag><tag count=\"4\" tag=\"jruby\"></tag><tag count=\"1\" tag=\"ldap\"></tag><tag count=\"5\" tag=\"linux\"></tag><tag count=\"1\" tag=\"madison\"></tag><tag count=\"1\" tag=\"metaverse\"></tag><tag count=\"3\" tag=\"mongodb\"></tag><tag count=\"3\" tag=\"mud\"></tag><tag count=\"5\" tag=\"music\"></tag><tag count=\"3\" tag=\"mysql\"></tag><tag count=\"6\" tag=\"nethack\"></tag><tag count=\"6\" tag=\"objective-c\"></tag><tag count=\"2\" tag=\"ooc\"></tag><tag count=\"18\" tag=\"osx\"></tag><tag count=\"8\" tag=\"perl\"></tag><tag count=\"16\" tag=\"php\"></tag><tag count=\"3\" tag=\"politics\"></tag><tag count=\"1\" tag=\"postgresql\"></tag><tag count=\"13\" tag=\"psp\"></tag><tag count=\"6\" tag=\"python\"></tag><tag count=\"21\" tag=\"rails\"></tag><tag count=\"22\" tag=\"reference\"></tag><tag count=\"46\" tag=\"ruby\"></tag><tag count=\"14\" tag=\"security\"></tag><tag count=\"11\" tag=\"social\"></tag><tag count=\"1\" tag=\"textmate\"></tag><tag count=\"39\" tag=\"tools\"></tag><tag count=\"1\" tag=\"travel\"></tag><tag count=\"2\" tag=\"ubiquity\"></tag><tag count=\"12\" tag=\"video\"></tag><tag count=\"4\" tag=\"vim\"></tag><tag count=\"39\" tag=\"webdesign\"></tag><tag count=\"8\" tag=\"webgame\"></tag><tag count=\"3\" tag=\"windows\"></tag><tag count=\"2\" tag=\"wireless\"></tag><tag count=\"1\" tag=\"xul\"></tag><tag count=\"5\" tag=\"zsh\"></tag></tags><!-- fe10.feeds.del.ac4.yahoo.net compressed/chunked Sun Mar 21 16:25:15 PDT 2010 -->"
          options:0
          error:&err];
//  tags = [[NSXMLDocument alloc]
//          initWithContentsOfURL:tagsURL
//          options:0
//          error:&err];
  NSLog(@"URL: %@", tagsURL);
  NSLog(@"TAGS: %@", tags);
}

@end
