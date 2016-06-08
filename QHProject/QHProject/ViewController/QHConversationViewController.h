//
//  QHConversationViewController.h
//  QHProject
//
//  Created by Chie Li on 16/6/3.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHBaseTableViewController.h"

@interface QHConversationViewController : QHBaseTableViewController

//- (instancetype)initWithConversation:(QHConversationModel *)conversation;
- (instancetype)initWithAVConvesation:(AVIMConversation *)conversation;

@end
