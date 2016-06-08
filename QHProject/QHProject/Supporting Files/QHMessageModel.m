//
//  QHMessageModel.m
//  QHProject
//
//  Created by Chie Li on 16/6/5.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHMessageModel.h"

@implementation QHMessageModel

+ (instancetype)textMessageWithTime:(NSDate *)time conversationId:(NSString *)conversationId fromId:(NSString *)fromId text:(NSString *)text
{
    return [self messageWithType:(QHMessageTypeText) time:time conversationId:conversationId fromId:fromId text:text imageURL:nil];
}

#pragma mark - private method
+ (instancetype)messageWithType:(QHMessageType)type time:(NSDate *)time conversationId:(NSString *)conversationId fromId:(NSString *)fromId text:(NSString *)text imageURL:(NSString *)imageURL
{
    QHMessageModel *model = [[QHMessageModel alloc] init];
    model.type = type;
    model.time = time;
    model.conversationId = conversationId;
    model.fromId = fromId;
    model.text = text;
    model.imageURL = imageURL;
    return model;
}

@end
