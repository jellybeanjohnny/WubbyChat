//
//  JoinChatViewController.m
//  TestChat
//
//  Created by Matt Amerige on 11/25/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import "JoinChatViewController.h"
#import "JBJChat.h"
#import "JBJPubNubConnectionManager.h"
#import "JBJConstants.h"

@interface JoinChatViewController ()
{
  __weak IBOutlet UITextField *_chatroomNameTextField;
  
}

@end

@implementation JoinChatViewController

/**
 Queries Parse for the specified Chatroom name. If a chat exists, the current user is added as a participant to the chat.
 If no chat matching the specified name exists, the JBJChat object is created with that name and stored on Parse.
 The current user is also subscribed to a PubNub channel with the same name as the chatroom.
 */
- (IBAction)_joinChatroom:(id)sender
{
  // Check to see if the chatroom already exists for the specified chat name
  PFQuery *chatroomQuery = [JBJChat query];
  [chatroomQuery whereKey:kJBJChatNameKey equalTo:_chatroomNameTextField.text];
  [chatroomQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    
    JBJChat *chatroom = nil;
    if (objects.count == 0) {
      // Chat does not exist, okay to create new chat object
      chatroom = [JBJChat object];
      chatroom.chatName = _chatroomNameTextField.text;
    } else {
      chatroom = (JBJChat *)objects[0];
    }
    
    if ([chatroom.participants containsObject:[PFUser currentUser].objectId]) {
      // User already part of this chat
      NSLog(@"Current user %@ is already a participant of chat titled %@", [PFUser currentUser].username, chatroom.chatName);
    } else {
      // Okay to add the current user as a participant of the chat
      if (!chatroom.participants) {
        chatroom.participants = [[NSMutableArray alloc] init];
      }
      [chatroom.participants addObject:[PFUser currentUser].objectId];
    }
    
    // Save chatroom object to Parse
    [chatroom saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
      if (error) {
        NSLog(@"Error saving chatroom: %@", error);
      } else {
        NSLog(@"Chat saved to Parse successfully");
        // Subscribe to the specified channel via PubNub
        [[JBJPubNubConnectionManager sharedInstance].client subscribeToChannels:@[chatroom.objectId] withPresence:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"Joined chatroom %@", _chatroomNameTextField.text);
      }
    }];
  }];
  
  
}

- (IBAction)_cancel:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
