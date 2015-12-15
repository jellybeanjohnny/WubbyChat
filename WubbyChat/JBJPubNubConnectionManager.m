//
//  JBJPubNub.m
//  TestChat
//
//  Created by Matt Amerige on 11/23/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import "JBJPubNubConnectionManager.h"
#import "JBJConstants.h"
#import "PlistManager.h"

@interface JBJPubNubConnectionManager() <PNObjectEventListener>
{
  PubNub *_client;
  __weak id<JBJPubNubMessageDelegate> _delegate;
}
@end

@implementation JBJPubNubConnectionManager


@synthesize client = _client;
@synthesize delegate = _delegate;

+ (JBJPubNubConnectionManager *)sharedInstance
{
  static JBJPubNubConnectionManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[JBJPubNubConnectionManager alloc] init];
  });
  return instance;
}

- (instancetype)init
{
  if (!(self = [super init])) {
    return nil;
  }
  
  return self;
}

/**
 @abstract Configures the basic setup required for PubNub
 @discussion Configures PubNub using the publish and subscribe keys, and adds this class as a listener for future PubNub changes
 */
- (void)setup
{
  PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:plistDataForKey(@"PubnubPublishKey")
                                                                   subscribeKey:plistDataForKey(@"PubnubSubscribeKey")];
  
  _client = [PubNub clientWithConfiguration:configuration];
  [_client addListener:self];
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message
{
  NSLog(@"MESSAGE RECEIVED: %@", message.data.message);
  NSLog(@"CHANNEL: %@", message.data.subscribedChannel);
  if (_delegate && [_delegate respondsToSelector:@selector(didReceiveMessage:onChannel:)]) {
    [_delegate didReceiveMessage:message.data onChannel:message.data.subscribedChannel];
  }
  else {
    NSLog(@"ERROR: JBJPubNubMessageDelegate is not set, or delegate does not respond to selector didReceiveMessage:onChannel:");
  }
}

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status
{
  if (status.category == PNUnexpectedDisconnectCategory) {
    // This event happens when radio / connectivity is lost
  }
  
  else if (status.category == PNConnectedCategory) {
    
    // Connect event. You can do stuff like publish, and know you'll get it.
    // Or just use the connected event to confirm you are subscribed for
    // UI / internal notifications, etc

  }
  else if (status.category == PNReconnectedCategory) {
    
    // Happens as part of our regular operation. This event happens when
    // radio / connectivity is lost, then regained.
  }
  else if (status.category == PNDecryptionErrorCategory) {
    
    // Handle messsage decryption error. Probably client configured to
    // encrypt messages and on live data feed it received plain text.
  }
}


@end
