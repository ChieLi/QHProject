//
//  QHConversationDatabase.h
//  QHProject
//
//  Created by Chie Li on 16/6/5.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHConversationDatabase : NSObject

+ (instancetype)sharedInstance;

- (void)addMessageIntoDatabase:(QHMessageModel *)message;

- (void)getMessagesWithConversationId:(NSString *)conversationId skip:(NSInteger)skip limit:(NSInteger)limit block:(QHArrayBlock)block;

@end
