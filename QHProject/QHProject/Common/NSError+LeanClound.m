//
//  NSError+LeanClound.m
//  QHProject
//
//  Created by Chie Li on 16/5/17.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "NSError+LeanClound.h"

@implementation NSError (LeanClound)

- (NSString *)detail
{
    return self.userInfo[@"error"];
}

@end
