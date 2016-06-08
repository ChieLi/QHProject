//
//  QHAPIClient.h
//  QHProject
//
//  Created by Chie Li on 16/5/27.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void (^SuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void (^ProgressBlock)(NSProgress * _Nonnull downloadProgress);
typedef void (^FailureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

@interface QHAPIClient : NSObject

+ (nonnull instancetype)shareInstance;

- (void)cancelAllRequests;

- (nullable id)get:(nullable NSString *)URLString
        parameters:(nullable NSDictionary *)parameters
          progress:(nullable ProgressBlock)progress
           success:(nullable SuccessBlock)success
           failure:(nullable FailureBlock)failure;

- (nullable id)post:(nullable NSString *)URLString
         parameters:(nullable NSDictionary *)parameters
           progress:(nullable ProgressBlock)progress
            success:(nullable SuccessBlock)success
            failure:(nullable FailureBlock)failure;

- (nullable id)masterPost:(nullable NSString *)URLString
               parameters:(nullable NSDictionary *)parameters
                 progress:(nullable ProgressBlock)progress
                  success:(nullable SuccessBlock)success
                  failure:(nullable FailureBlock)failure;



@end
