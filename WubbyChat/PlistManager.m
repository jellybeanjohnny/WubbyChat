//
//  PlistManager.m
//  WubbyChat
//
//  Created by Matt Amerige on 12/14/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistManager.h"

NSString * plistDataForKey(NSString *key)
{
  NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PrivateKeys" ofType:@"plist"]];
  return [dictionary objectForKey:key];
}
