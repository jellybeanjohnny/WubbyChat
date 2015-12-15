//
//  ChatRoomTableViewController.m
//  TestChat
//
//  Created by Matt Amerige on 11/25/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import "ChatRoomTableViewController.h"
#import "JBJMessageTableViewCell.h"
#import <Parse/Parse.h>

static NSString *const kMyMessageCell = @"MyMessage";
static NSString *const kFriendMessageCell = @"FriendMessage";

@interface ChatRoomTableViewController ()
{
  NSMutableArray<NSDictionary *> *_messages;
}
@end

@implementation ChatRoomTableViewController
@synthesize messages = _messages;

- (void)viewDidLoad
{
  [super viewDidLoad];
  _messages = [[NSMutableArray alloc] init];
}


/**
 Message dictionary will follow the below format:
  "username"       : username
  "user object id" : user object id
  "message"        : message
 */
- (void)addMessage:(NSDictionary *)messageDictionary
{
  [_messages addObject:messageDictionary];
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // TODO: Swap out these literal strings with constants
  NSDictionary *messageDictionary = _messages[indexPath.row];
  NSString *cellIdentifier = nil;
  NSString *cellMessageContent = nil;
  if ([messageDictionary[@"user object id"] isEqualToString:[PFUser currentUser].objectId]) {
    cellIdentifier = kMyMessageCell;
    cellMessageContent = messageDictionary[@"message"];
  } else {
    cellIdentifier = kFriendMessageCell;
    cellMessageContent = [NSString stringWithFormat:@"%@: %@", messageDictionary[@"username"], messageDictionary[@"message"]];
  }
  
  JBJMessageTableViewCell *cell = (JBJMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[JBJMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  // Configure the cell
  cell.message.text = cellMessageContent;
  
  return cell;
}


@end
