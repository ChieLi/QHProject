//
//  QHConversationTextMessageCell.m
//  QHProject
//
//  Created by Chie Li on 16/6/9.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHConversationTextMessageCell.h"

@interface QHConversationTextMessageCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleViewBottonConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleViewRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleViewLeftConstraint;

@end

@implementation QHConversationTextMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
