//
//  JBJConstants.h
//  TestChat
//
//  Created by Matt Amerige on 11/22/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JBJConstants : NSObject

#pragma mark - Parse
extern NSString *const kParseApplicationIdKey;
extern NSString *const kParseClientIdKey;
extern NSString *const kParseObjectIdKey;

#pragma mark - JBJChat
extern NSString *const kJBJChatNameKey;
extern NSString *const kJBJChatParticipantsKey;
extern NSString *const kJBJChatMessagesKey;

#pragma mark - PubNub
extern NSString *const kPubNubPublishKey;
extern NSString *const kPubNubSubscribeKey;



@end
