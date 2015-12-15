//
//  JBJChat.h
//  TestChat
//
//  Created by Matt Amerige on 10/18/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import <Parse/Parse.h>

@interface JBJChat : PFObject<PFSubclassing>

// Required to implement for PFObject subclassing
+ (NSString *)parseClassName;

/**
 @abstract Messages that belong to the chat
 */
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *messages;

/**
 @abstract Object ids of people who are participants in the chat
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *participants;

/**
 @abstract Name of the chat
 */
@property (nonatomic, copy) NSString *chatName;

@end
