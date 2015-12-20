//
//  ChatListViewController.m
//  TestChat
//
//  Created by Matt Amerige on 10/17/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import "ChatListViewController.h"
#import <Parse/Parse.h>
#import "JBJChat.h"
#import "JBJConstants.h"
#import "ChatViewController.h"
#import "JBJChatTableViewCell.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  if (![PFUser currentUser]) {
    // User is not logged in, show login screen
    [self performSegueWithIdentifier:@"ShowLogin" sender:self];
  }
}

#pragma mark - PFQueryTableViewController


- (PFQuery *)queryForTable
{
  if (![PFUser currentUser]) {
    return nil;
  }
  PFQuery *query = [JBJChat query];
  [query whereKey:kJBJChatParticipantsKey equalTo:[PFUser currentUser].objectId];

  // If Pull To Refresh is enabled, query against the network by default.
  if (self.pullToRefreshEnabled) {
    query.cachePolicy = kPFCachePolicyNetworkOnly;
  }
  // If no objects are loaded in memory, we look to the cache first to fill the table
  // and then subsequently do a query against the network.
  if (self.objects.count == 0) {
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
  }

  [query orderByDescending:@"createdAt"];

  return query;
}
 


 // Override to customize the look of a cell representing an object. The default is to display
 // a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
 // and the imageView being the imageKey in the object.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
  JBJChat *chatObject = (JBJChat *)object;
  static NSString *cellIdentifier = @"ChatCell";
  JBJChatTableViewCell *cell = (JBJChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[JBJChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  cell.chatNameLabel.text = chatObject.chatName;
  cell.channel = chatObject.objectId;
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"ShowChat"] && [segue.destinationViewController isKindOfClass:[ChatViewController class]]) {
    ChatViewController *chatroom = (ChatViewController *)segue.destinationViewController;
    JBJChatTableViewCell *cell;
    if ([sender isKindOfClass:[UITableViewCell class]]) {
      cell = (JBJChatTableViewCell *)sender;
      chatroom.channel = cell.channel;
    }
  }
}

/**
 Unwind segue
 */
- (IBAction)_unwindToChatList:(UIStoryboardSegue *)segue
{
  
}





@end
