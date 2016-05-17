//
//  QHUserManager.h
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QHUserModel;

@interface QHUserManager : NSObject

+ (QHUserModel *)currentUser;

+ (void)requestPhoneNumberVerify:(NSString *)phoneNumber block:(QHBooleanBlock)block;

+ (void)registerWithEmail:(NSString *)email password:(NSString *)password block:(QHBooleanBlock)block;

+ (void)registerWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password block:(QHBooleanBlock)block;
+ (void)verifyPhoneNumberWithsmsCode:(NSString *)smsCode block:(QHBooleanBlock)block;

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(QHBooleanBlock)block;


@end
