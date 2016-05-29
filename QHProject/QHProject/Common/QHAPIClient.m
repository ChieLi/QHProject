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

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

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
        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kQHBaseURL]];
//        self.requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        self.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.requestManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"text/json", @"application/json", @"application/vnd.apple.pkpass", nil]];
        
        [self.requestManager.requestSerializer setValue:kQHAPIId forHTTPHeaderField:@"X-LC-Id"];
        [self.requestManager.requestSerializer setValue:kQHAPIKey forHTTPHeaderField:@"X-LC-Key:"];
//        [self.requestManager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"application/json"];
        [self.requestManager.requestSerializer setTimeoutInterval:kQHAPICLientTimeOut];
        
    }
    return self;
}

- (void)cancelAllRequests
{
    [self.requestManager.operationQueue cancelAllOperations];
}

- (id)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    return [self.requestManager GET:URLString parameters:parameters success:success failure:failure];
    
    
}

- (id)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    return [self.requestManager POST:URLString parameters:parameters success:success failure:failure];
}

#pragma mark - private
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
@end
