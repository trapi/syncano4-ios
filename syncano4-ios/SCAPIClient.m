//
//  SCAPIClient.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCAPIClient.h"
#import "Syncano.h"

@interface SCAPIClient ()
@property (nonatomic,copy) NSString *apiKey;
@property (nonatomic,copy) NSString *instanceName;
@end

@implementation SCAPIClient
SINGLETON_IMPL_FOR_CLASS(SCAPIClient)



- (instancetype)init {
//    NSURL *instanceURL = [NSURL URLWithString:@"http://ip.jsontest.com"];
    NSURL *instanceURL = [NSURL URLWithString:[Syncano getInstanceName] relativeToURL:[NSURL URLWithString:kBaseURL]];
    self = [super initWithBaseURL:instanceURL];
    if (self) {
        [self initializeClient];
    }
    return self;
}

- (void)initializeClient {
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    [self authorizeRequest];
    self.securityPolicy.allowInvalidCertificates = YES;
}

+ (SCAPIClient *)apiClientForSyncano:(Syncano *)syncano {
    NSURL *instanceURL = [NSURL URLWithString:syncano.instanceName relativeToURL:[NSURL URLWithString:kBaseURL]];
    SCAPIClient *apiClient = [[SCAPIClient alloc] initWithBaseURL:instanceURL];
    [apiClient initializeClient];
    return apiClient;
}

- (void)authorizeRequest {
   [self.requestSerializer setValue:[Syncano getApiKey] forHTTPHeaderField:@"X-API-KEY"];
}

- (NSURLSessionDataTask *)getTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion {
    [self authorizeRequest];
    NSURLSessionDataTask *task = [self GET:path
                                parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       completion(task,responseObject, nil);
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       completion(task,nil, error);
                                   }];
    
    return task;
}
//TODO: NEEDS TO BE IMPLEMENTED
- (NSURLSessionDataTask *)postTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion {
    return [NSURLSessionDataTask new];
}
//TODO: NEEDS TO BE IMPLEMENTED
- (NSURLSessionDataTask *)putTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion {
    return [NSURLSessionDataTask new];
}
//TODO: NEEDS TO BE IMPLEMENTED
- (NSURLSessionDataTask *)deleteTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion {
    return [NSURLSessionDataTask new];
}

@end
