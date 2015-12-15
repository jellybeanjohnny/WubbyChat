//
//  ChatRoomTableViewController.h
//  TestChat
//
//  Created by Matt Amerige on 11/25/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChatRoomTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *messages;

- (void)addMessage:(NSDictionary *)message;

@end
