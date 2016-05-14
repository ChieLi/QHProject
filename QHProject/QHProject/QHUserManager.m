//
//  QHUserManager.m
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHUserManager.h"
#import "QHUserModel.h"

static QHUserModel *sharedUser = nil;

@implementation QHUserManager

+ (QHUserModel *)currentUser
{
    if ([AVUser currentUser]) {
        sharedUser = [[QHUserModel alloc] init];
        [self transferAVUser:[AVUser currentUser] toQHUser:sharedUser];
    } else {
        sharedUser = nil;
    }

    return sharedUser;
}

+ (void)requestPhoneNumberVerify:(NSString *)phoneNumber block:(QHBooleanBlock)block
{
    [AVUser requestMobilePhoneVerify:phoneNumber withBlock:block];
}

#pragma mark - register
+ (void)registerWithEmail:(NSString *)email password:(NSString *)password block:(QHBooleanBlock)block
{
    AVUser *avUser = [AVUser user];
    avUser.username = email;
    avUser.password = password;
    
    [avUser signUpInBackgroundWithBlock:block];
}

+ (void)registerWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password block:(QHBooleanBlock)block
{
    AVUser *avUser = [AVUser user];
    avUser.username = [NSString stringWithFormat:@"auto_%@", phoneNumber];
    avUser.password = password;
    avUser.mobilePhoneNumber = phoneNumber;
    
    [avUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [AVUser verifyMobilePhone:phoneNumber withBlock:block];
        } else {
            block(succeeded, error);
        }
    }];
}

#pragma mark - login
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password block:(QHBooleanBlock)block
{
    if ([username containsString:@"@"]) {
        // 邮箱登录
        [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
            if (error) {
                block(NO, error);
            } else {
                block(YES, nil);
            }
        }];
    } else {
        // 手机号登录
        [AVUser logInWithMobilePhoneNumberInBackground:username password:password block:^(AVUser *user, NSError *error) {
            
            if (error) {
                block(NO, error);
            } else {
                block(YES, nil);
            }
        }];
    }
}

#pragma mark - private method
+ (void)transferAVUser:(AVUser *)avUser toQHUser:(QHUserModel *)qhUser
{
    qhUser.username = avUser.username;
    qhUser.email = avUser.email;
    qhUser.phoneNumber = avUser.mobilePhoneNumber;
    qhUser.nickname = [avUser valueForKey:@"nickname"];
    qhUser.pictureURL = [avUser valueForKey:@"pictureURL"];
}

@end
