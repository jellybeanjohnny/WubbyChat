//
//  ChatViewController.m
//  TestChat
//
//  Created by Matt Amerige on 10/17/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import "ChatViewController.h"
#import <POP/POP.h>
#import "JBJPubNubConnectionManager.h"
#import "ChatRoomTableViewController.h" // Does not use Parse
#import "JBJConstants.h"
#import "JBJChat.h"

typedef enum MessageBarPosition
{
  BarPositionUp,
  BarPositionDown
} MessageBarPosition;

@interface ChatViewController () <JBJPubNubMessageDelegate>
{
  __weak IBOutlet UIView *_messageBarView;
  __weak IBOutlet UITextField *_messageTextField;
  __weak IBOutlet NSLayoutConstraint *_messageBarBottomOffset;
  ChatRoomTableViewController *_chatRoomTableViewController;
  
  NSString *_channel;
  PubNub *_client;
  JBJChat *_chat;
}
@end

@implementation ChatViewController
@synthesize channel = _channel;

#pragma mark - Setup
- (void)viewDidLoad
{
  [self _setupPubNub];
  [self _setupKeyboard];
  
  // Get the instance of the ChatRoomTableViewController for this chat
  _chatRoomTableViewController = self.childViewControllers[0];
  
  [self _retrieveParseChatData];
 
  
}

- (void)_setupPubNub
{
  // Get the shared instance of the PubNub client
  _client = [JBJPubNubConnectionManager sharedInstance].client;
  
  // Assign self as the delegate to receive messages
  [JBJPubNubConnectionManager sharedInstance].delegate = self;
  
  // Subscribe to the channel for this chat
  [_client subscribeToChannels:@[_channel] withPresence:YES];
}

- (void)_retrieveParseChatData
{
  // Query for the JBJChat Object that corresponds to this chat
  PFQuery *chatQuery = [JBJChat query];
  [chatQuery getObjectInBackgroundWithId:_channel block:^(PFObject * _Nullable object, NSError * _Nullable error) {
    if (!error) {
      _chat = (JBJChat *)object;
      if (_chat.messages.count > 0) {
        _chatRoomTableViewController.messages = _chat.messages;
        [_chatRoomTableViewController.tableView reloadData];
      }
    }
    else {
      NSLog(@"Error finding Chat Object for channel %@: %@", _channel, error);
    }
  }];
}

#pragma mark - Sending & Receiving Messages

- (IBAction)_sendMessage:(UIButton *)sender
{
  NSDictionary *messageDictionary = @{@"username" : [PFUser currentUser].username,
                                      @"user object id" : [PFUser currentUser].objectId,
                                      @"message" : _messageTextField.text};


  [_client publish:messageDictionary toChannel:_channel
          withCompletion:^(PNPublishStatus *status) {
            if (!status.isError) {
              // success
              _messageTextField.text = @"";
              
              // Save message to the chat's log
              [_chat addObject:messageDictionary forKey:kJBJChatMessagesKey];
              [_chat saveEventually];
            }
            else {
              // fail
            }
          }];
}

- (void)didReceiveMessage:(PNMessageData *)messageData onChannel:(NSString *)channel
{
  [_chatRoomTableViewController addMessage:messageData.message];
}

#pragma mark - Bottom Message Bar & Keyboard


- (void)_setupKeyboard
{
  // Register for keyboard notifications
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(_raiseMessageBar:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(_lowerMessageBar:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
  
  
  // Tap gesture recognizer to dismiss keyboard
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(_dismissKeyboard)];
  [self.view addGestureRecognizer:tapGesture];

  
  
}

- (void)_dismissKeyboard
{
  if ([_messageTextField isFirstResponder]) {
    [_messageTextField resignFirstResponder];
  }
}

- (void)_raiseMessageBar:(NSNotification *)notification
{
  [self _moveMessageBarToPosition:BarPositionUp notification:notification];
}

- (void)_lowerMessageBar:(NSNotification *)notification
{
  [self _moveMessageBarToPosition:BarPositionDown notification:notification];
}

- (void)_moveMessageBarToPosition:(MessageBarPosition)barPosition notification:(NSNotification *)notification
{
  CGFloat toValue = 0;
  if (barPosition == BarPositionUp) {
    toValue = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
  }
  
  POPSpringAnimation *moveAnim = [_messageBarBottomOffset pop_animationForKey:@"MoveAnimation"];
  if (moveAnim) {
    moveAnim.toValue = @(toValue);
  }
  else {
    moveAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    moveAnim.toValue = @(toValue);
    [_messageBarBottomOffset pop_addAnimation:moveAnim forKey:@"MoveAnimation"];
  }
}

@end
