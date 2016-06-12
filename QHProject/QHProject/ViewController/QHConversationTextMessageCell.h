//
//  QHConversationTextMessageCell.h
//  QHProject
//
//  Created by Chie Li on 16/6/9.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHConversationTextMessageCell : UITableViewCell

- (void)setUpWithMessageModel:(QHMessageModel *)messageModel;
- (CGFloat)cellHeightWithText:(NSString *)text;
@end
