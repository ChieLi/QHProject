//
//  QHConversationManager.m
//  QHProject
//
//  Created by Chie Li on 16/5/26.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHConversationManager.h"
//#import "QHAPIClient+Conversation.h"
#import "QHConversationDatabase.h"

@interface QHConversationManager () <AVIMClientDelegate>

@property (nonatomic, strong) AVIMClient *imClient;
@property (nonatomic, assign) BOOL isNetworkingAvailable;


//@property (nonatomic, strong) NSArray *offlineConversationArray;
//@property (nonatomic, strong) NSDictionary *offlineContactsDictionary;


@property (nonatomic, strong) NSString *databaseBasePath;

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

- (void)changeConversationDelegate:(id<QHConversationDelegate>)delegate
{
    if (self.delegate) {
        self.delegate = nil;
    }
    self.delegate = delegate;
    
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
        weakSelf.imClient.delegate = self;
        block(YES,nil);
    }];
    
}

- (void)findConversationWithUserIds:(NSArray *)userIdsArray type:(QHConversationType)type callBackBlock:(void(^)(AVIMConversation *conversation, NSError *error))conversationBlock
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
            [weakSelf.imClient createConversationWithName:nil clientIds:userIdsArray attributes:@{@"type":@(type)} options:(AVIMConversationOptionNone) callback:^(AVIMConversation *conversation, NSError *error) {
                conversationBlock(conversation, error);
            }];
        } else {
            conversationBlock(objects.firstObject, error);
        }
        
    }];

}

//- (void)findConversationWithMembersIds:(NSArray *)IdsArray type:(QHConversationType)type block:(QHConversationBlock)block
//{
//    BOOL isAllReadyExist = NO;
//    for (QHConversationModel *currentConversation in self.offlineConversationArray) {
//        if ([currentConversation containsAllMembersWithIds:IdsArray]) {
//            isAllReadyExist = YES;
//            block(currentConversation, nil);
//            return;
//        }
//    }
//    
//    if (isAllReadyExist == NO) {
//        [[QHAPIClient shareInstance] postCreateConversationWithName:nil menbersIds:IdsArray type:type success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            if (responseObject) {
//                QHConversationModel *conversation = [[QHConversationModel alloc] initWithDictionary:responseObject error:nil];
//                conversation.membersId = IdsArray;
//                block(conversation, nil);
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            block(nil, error);
//        }];
//    }
//}
//
//- (void)sendTxtMessageWithFromId:(NSString *)fromId conversationId:(NSString *)conversationId txt:(NSString *)txt block:(QHBooleanBlock)block
//{
//    [[QHAPIClient shareInstance] postSendTxtMessageWithFromId:fromId conversationId:conversationId txt:txt success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        block(YES, nil);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        block(NO, error);
//        
//    }];
//    
//}

- (void)sendTextMessage:(NSString *)text toConversation:(AVIMConversation *)conversation block:(QHBooleanBlock)block
{
    if (text.length != 0) {
        AVIMTextMessage *textMessage = [AVIMTextMessage messageWithText:text attributes:nil];
        [conversation sendMessage:textMessage callback:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                QHMessageModel *qhMessage = [QHMessageModel textMessageWithTime:[NSDate date] conversationId:conversation.conversationId fromId:[QHUserManager currentUser].objectId text:text];
                [[QHConversationDatabase sharedInstance] addMessageIntoDatabase:qhMessage];
            }
            block(succeeded, error);
        }];
    }
}


- (void)getMessagesWithConversationId:(NSString *)conversationId  skip:(NSInteger)skip limit:(NSInteger)limit block:(QHArrayBlock)block
{
    [[QHConversationDatabase sharedInstance] getMessagesWithConversationId:conversationId skip:skip limit:limit block:^(NSArray *array, NSError *error) {
        block(array, error);
    }];
}
#pragma mark - AVIMClientDelegate

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message
{
    QHMessageModel *qhMessage = [[QHMessageModel alloc] init];
    qhMessage.time = [NSDate dateWithTimeIntervalSinceReferenceDate:message.sendTimestamp/1000];
    qhMessage.conversationId = message.conversationId;
    qhMessage.fromId = message.clientId;
    
    switch (message.mediaType) {
        case kAVIMMessageMediaTypeText:
            qhMessage.type = QHMessageTypeText;
            qhMessage.text = message.text;
            break;
            
        default:
            break;
    }
    
    [[QHConversationDatabase sharedInstance] addMessageIntoDatabase:qhMessage];
    
    if ([self.delegate respondsToSelector:@selector(qhNewMessageReceived:)]) {
        [self.delegate qhNewMessageReceived:qhMessage];
    }
}

- (void)conversation:(AVIMConversation *)conversation messageDelivered:(AVIMMessage *)message
{

}

- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message
{

}
#pragma mark - property getter


//- (NSArray *)offlineConversationArray
//{
//    if (!_offlineConversationArray) {
//        _offlineConversationArray = [[QHFileManager shareOfflineFileInstance] readArrayAtPath:kQHFileManagerConversationPath];
//    }
//    return _offlineConversationArray;
//}
//
//- (NSDictionary *)offlineContactsDictionary
//{
//    if (!_offlineContactsDictionary) {
//        _offlineContactsDictionary = [[QHFileManager shareOfflineFileInstance] readDictionaryAtPath:kQHFileManagerContactsPath];
//    }
//    return _offlineContactsDictionary;
//}




@end
