//
//  JBJChatTableViewCell.h
//  TestChat
//
//  Created by Matt Amerige on 12/13/15.
//  Copyright © 2015 Wubbyland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBJChatTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *channel;
@property (weak, nonatomic) IBOutlet UILabel *chatNameLabel;

@end
