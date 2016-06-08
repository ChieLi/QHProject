//
//  QHAPIClient.m
//  QHProject
//
//  Created by Chie Li on 16/5/27.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHAPIClient.h"
#import "QHAPIDefine.h"

@interface QHAPIClient ()

@property (nonatomic, strong) AFHTTPSessionManager *getSessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *postSessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *masterPostSessionManager;

@end

@implementation QHAPIClient

+ (instancetype)shareInstance
{
    static QHAPIClient *sharedInstabce = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstabce = [[QHAPIClient alloc] init];
    });
    return sharedInstabce;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.getSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kQHBaseURL]];
        [self.getSessionManager.requestSerializer setValue:kQHAPIId forHTTPHeaderField:@"X-LC-Id"];
        [self.getSessionManager.requestSerializer setValue:kQHAPIKey forHTTPHeaderField:@"X-LC-Key"];
        
        self.postSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kQHBaseURL]];
        self.postSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.postSessionManager.requestSerializer setValue:kQHAPIId forHTTPHeaderField:@"X-LC-Id"];
        [self.postSessionManager.requestSerializer setValue:kQHAPIKey forHTTPHeaderField:@"X-LC-Key"];
        [self.postSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        self.masterPostSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kQHBaseURL]];
        self.masterPostSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.masterPostSessionManager.requestSerializer setValue:kQHAPIId forHTTPHeaderField:@"X-LC-Id"];
        [self.masterPostSessionManager.requestSerializer setValue:kQHAPIMasterKey forHTTPHeaderField:@"X-LC-Key"];
        [self.masterPostSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
    }
    return self;
}

- (void)cancelAllRequests
{
    [self.getSessionManager.operationQueue cancelAllOperations];
    [self.postSessionManager.operationQueue cancelAllOperations];
}

- (id)get:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure
{
    return [self.getSessionManager GET:URLString parameters:parameters progress:progress success:success failure:failure];
}

- (id)post:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure
{
    return [self.postSessionManager POST:URLString parameters:parameters progress:progress success:success failure:failure];
}

- (id)masterPost:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure
{
    return [self.masterPostSessionManager POST:URLString parameters:parameters progress:progress success:success failure:failure];
}

@end
