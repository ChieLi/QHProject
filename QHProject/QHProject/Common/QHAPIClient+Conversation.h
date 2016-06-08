//
//  QHAPIClient+Conversation.h
//  QHProject
//
//  Created by Chie Li on 16/6/2.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHAPIClient.h"

@interface QHAPIClient (Conversation)

- (id)postCreateConversationWithName:(NSString *)name
                          menbersIds:(NSArray *)IdsArray
                                type:(QHConversationType)type
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure;

- (id)postSendTxtMessageWithFromId:(NSString *)fromId
                    conversationId:(NSString *)conversatioId
                               txt:(NSString *)txt
                           success:(SuccessBlock)success
                           failure:(FailureBlock)failure;

@end
