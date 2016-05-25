//
//  QHAppSkinManager.m
//  QHProject
//
//  Created by Chie Li on 16/5/24.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHAppSkinManager.h"

@implementation QHAppSkinManager

+ (instancetype)defaultAppSkinManager
{
    static QHAppSkinManager *defaultAppSkinManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAppSkinManager = [[QHAppSkinManager alloc] init];
    });
    return defaultAppSkinManager;
}

@end
