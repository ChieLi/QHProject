//
//  QHUserManager.m
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHUserManager.h"
#import "QHAPIClient+User.h"

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
    [AVOSCloud requestSmsCodeWithPhoneNumber:phoneNumber callback:block];
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
    avUser.username = [NSString stringWithFormat:@"user_%@", phoneNumber];
    avUser.password = password;
    avUser.mobilePhoneNumber = phoneNumber;
    
    [avUser signUpInBackgroundWithBlock:block];
}

+ (void)verifyPhoneNumberWithsmsCode:(NSString *)smsCode block:(QHBooleanBlock)block
{
   [AVUser verifyMobilePhone:smsCode withBlock:block];
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
//        [[QHAPIClient shareInstance] getUserLoginWithEmail:username password:password success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@", responseObject);
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@", error);
//        }];
    
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

#pragma mark - logout
+ (void)logout
{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser) {
        [AVUser logOut];
    }
}


#pragma mark - Utils
+ (void)transferAVUser:(AVUser *)avUser toQHUser:(QHUserModel *)qhUser
{
    qhUser.objectId = avUser.objectId;
    qhUser.username = avUser.username;
    qhUser.email = avUser.email;
    qhUser.phoneNumber = avUser.mobilePhoneNumber;
    qhUser.nickname = [avUser valueForKey:@"nickname"];
    qhUser.pictureURL = [avUser valueForKey:@"pictureURL"];
}

@end
