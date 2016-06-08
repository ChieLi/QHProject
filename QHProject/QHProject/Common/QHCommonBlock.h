//
//  QHCommonBlock.h
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^QHBlock)(void);
typedef void(^QHBooleanBlock)(BOOL boolean, NSError *error);
typedef void(^QHArrayBlock)(NSArray *array, NSError *error);
//typedef void(^QHConversationBlock)(AVIMConversation *conversation, NSError *error);
typedef void(^QHConversationBlock)(QHConversationModel *conversation, NSError *error);