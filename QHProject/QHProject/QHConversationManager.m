//
//  QHConversationManager.m
//  QHProject
//
//  Created by Chie Li on 16/5/26.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHConversationManager.h"

@interface QHConversationManager ()

@property (nonatomic, strong) AVIMClient *imClient;

@end

@implementation QHConversationManager

+ (instancetype)sharedInstance
{
    static QHConversationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[QHConversationManager alloc] init];
    });
    return sharedInstance;
}

- (void)openClientWithCallBackBlock:(QHBooleanBlock)block
{
    AVIMClient *imClient = [[AVIMClient alloc] initWithClientId:[QHUserManager currentUser].objectId];
    WS(weakSelf)
    [imClient openWithCallback:^(BOOL succeeded, NSError *error) {
        if (error) {
            block(NO, error);
            return ;
        }
        weakSelf.imClient = imClient;
        block(YES,nil);
    }];
    block = nil;
}

- (void)findConversationWithUserIds:(NSArray *)userIdsArray type:(QHConversationType)type callBackBlock:(QHConversationBlock)conversationBlock
{
    WS(weakSelf)
    AVIMConversationQuery *query = [self.imClient conversationQuery];
    query.limit = 10;
    query.skip = 0;
    [query whereKey:kAVIMKeyMember containsAllObjectsInArray:userIdsArray];
    [query whereKey:AVIMAttr(@"type") equalTo:@(type)];
    [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
        if (error) {

            conversationBlock(nil, error);
        } else if (!objects || objects.count < 1) {
            
            [weakSelf.imClient createConversationWithName:nil clientIds:userIdsArray callback:^(AVIMConversation *conversation, NSError *error) {
                if (error) {
                    conversationBlock(nil, error);
                    return ;
                } else {
                    [weakSelf.imClient createConversationWithName:nil clientIds:userIdsArray attributes:@{@"type":@(type)} options:(AVIMConversationOptionNone) callback:^(AVIMConversation *conversation, NSError *error) {
                        conversationBlock(conversation, error);
                    }];
                }
            }];
        } else {
            conversationBlock(objects.firstObject, error);
        }
    }];
    conversationBlock = nil;
}

@end
