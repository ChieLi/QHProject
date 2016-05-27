//
//  QHConversationManager.h
//  QHProject
//
//  Created by Chie Li on 16/5/26.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVIMClient;

typedef NS_ENUM(NSInteger, QHConversationType) {
    QHConversationTypeSingle,
    QHCOnversationTypeMultiplier
};

@interface QHConversationManager : NSObject

+ (instancetype)sharedInstance;

// 打开通讯功能
- (void)openClientWithCallBackBlock:(QHBooleanBlock)block;
// 查找对话，若无对话，新建一个，并返回会话
- (void)findConversationWithUserIds:(NSArray *)userIdsArray type:(QHConversationType)type callBackBlock:(QHConversationBlock)conversationBlock;

@end
