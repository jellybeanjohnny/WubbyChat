//
//  JBJPubNub.h
//  TestChat
//
//  Created by Matt Amerige on 11/23/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PubNub/PubNub.h>

@protocol JBJPubNubMessageDelegate <NSObject>

- (void)didReceiveMessage:(PNMessageData *)messageData onChannel:(NSString *)channel;

@end

@interface JBJPubNubConnectionManager : NSObject

@property (nonatomic, strong) PubNub *client;
@property (nonatomic, weak) id<JBJPubNubMessageDelegate> delegate;

+ (JBJPubNubConnectionManager *)sharedInstance;
- (void)setup;




@end
