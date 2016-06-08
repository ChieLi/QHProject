//
//  QHAPIClient+User.m
//  QHProject
//
//  Created by Chie Li on 16/5/27.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHAPIClient+User.h"

@implementation QHAPIClient (User)

- (id)getUserLoginWithEmail:(NSString *)email password:(NSString *)password success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSDictionary *params = @{@"username":email,
                             @"password":password};
    return [self get:@"/1.1/login" parameters:params progress:nil success:success failure:failure];
}


@end
