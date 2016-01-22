//
//  JBJChat.m
//  TestChat
//
//  Created by Matt Amerige on 10/18/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import "JBJChat.h"

@interface JBJChat ()
{

}

@end

@implementation JBJChat

@dynamic messages, chatName, participants;

+ (void)load
{
  [self registerSubclass];
}

+ (NSString *)parseClassName
{
  return @"Chat";
}

@end
