//
//  QHAPIClient.h
//  QHProject
//
//  Created by Chie Li on 16/5/27.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^SuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface QHAPIClient : NSObject

+ (instancetype)shareInstance;

- (void)cancelAllRequests;

- (id)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;
- (id)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
