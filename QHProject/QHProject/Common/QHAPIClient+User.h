//
//  QHAPIClient+User.h
//  QHProject
//
//  Created by Chie Li on 16/5/27.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHAPIClient.h"

@interface QHAPIClient (User)


- (id)getUserLoginWithEmail:(NSString *)email password:(NSString *)password success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
