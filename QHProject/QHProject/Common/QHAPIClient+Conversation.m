//
//  QHAPIClient+Conversation.m
//  QHProject
//
//  Created by Chie Li on 16/6/2.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHAPIClient+Conversation.h"


@implementation QHAPIClient (Conversation)

- (id)postCreateConversationWithName:(NSString *)name menbersIds:(NSArray *)IdsArray type:(QHConversationType)type success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safeSetValue:name forKey:@"name"];
    [params setValue:IdsArray forKey:@"m"];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes safeSetValue:@(type) forKey:@"type"];
    [params setValue:attributes forKey:@"attr"];
    
    return [self post:@"/1.1/classes/_Conversation" parameters:params progress:nil success:success failure:failure];
}

- (id)postSendTxtMessageWithFromId:(NSString *)fromId conversationId:(NSString *)conversatioId txt:(NSString *)txt success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:fromId forKey:@"from_peer"];
    [params setValue:conversatioId forKey:@"conv_id"];
    [params setValue:@"false" forKey:@"transient"];
    [params setValue:txt forKey:@"message"];
    
//    NSDictionary *messageDic = @{@"_lctype":[NSNumber numberWithInteger:QHMessageTypeText],
//                                 @"_lctext":txt};
//    [params setValue:messageDic forKey:@"message"];
    
    return [self masterPost:@"/1.1/rtm/messages" parameters:params progress:nil success:success failure:failure];
}



@end
