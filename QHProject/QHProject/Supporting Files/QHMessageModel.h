//
//  QHMessageModel.h
//  QHProject
//
//  Created by Chie Li on 16/6/5.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QHMessageType) {
    QHMessageTypeText,
    QHMessageTypeImage
};

@interface QHMessageModel : NSObject

@property (nonatomic, assign) QHMessageType type;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, copy) NSString *conversationId;
@property (nonatomic, copy) NSString *fromId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *imageURL;

+ (instancetype)textMessageWithTime:(NSDate *)time conversationId:(NSString *)conversationId fromId:(NSString *)fromId text:(NSString *)text;

@end
