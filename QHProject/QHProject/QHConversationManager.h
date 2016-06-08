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

@protocol QHConversationDelegate <NSObject>
- (void)qhNewMessageReceived:(QHMessageModel *)message;
@end

@interface QHConversationManager : NSObject


@property (nonatomic, weak) id<QHConversationDelegate>delegate;


+ (instancetype)sharedInstance;

- (void)changeConversationDelegate:(id<QHConversationDelegate>)delegate;
// 需要接受信息必须打开
- (void)openClientWithCallBackBlock:(QHBooleanBlock)block;

- (void)findConversationWithUserIds:(NSArray *)userIdsArray type:(QHConversationType)type callBackBlock:(void(^)(AVIMConversation *conversation, NSError *error))conversationBlock;

- (void)sendTextMessage:(NSString *)text toConversation:(AVIMConversation *)conversation block:(QHBooleanBlock)block;

- (void)getMessagesWithConversationId:(NSString *)conversationId  skip:(NSInteger)skip limit:(NSInteger)limit block:(QHArrayBlock)block;

@end
