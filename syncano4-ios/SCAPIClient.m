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

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self authorizeRequest];
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

+ (SCAPIClient *)apiClientForSyncano:(Syncano *)syncano {
    NSURL *instanceURL = [NSURL URLWithString:syncano.instanceName relativeToURL:[NSURL URLWithString:kBaseURL]];
    SCAPIClient *apiClient = [[SCAPIClient alloc] initWithBaseURL:instanceURL];
    return apiClient;
}

- (void)authorizeRequest {
   [self.requestSerializer setValue:[Syncano getApiKey] forHTTPHeaderField:@"X-API-KEY"];
    if ([SCUser currentUser]) {
        NSString *userKey = [SCUser currentUser].userKey;
        [self.requestSerializer setValue:userKey forHTTPHeaderField:@"X-USER-KEY"];
    }
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

- (NSURLSessionDataTask *)postTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion {
    [self authorizeRequest];
    NSURLSessionDataTask *task = [self POST:path
                                parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       completion(task,responseObject, nil);
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       completion(task,nil, error);
                                   }];
    
    return task;
}

- (NSURLSessionDataTask *)putTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion {
    [self authorizeRequest];
    NSURLSessionDataTask *task = [self PUT:path
                                 parameters:params
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        completion(task,responseObject, nil);
                                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        completion(task,nil, error);
                                    }];
    
    return task;
}

- (NSURLSessionDataTask *)deleteTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion {
    [self authorizeRequest];
    NSURLSessionDataTask *task = [self DELETE:path
                                 parameters:params
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        completion(task,responseObject, nil);
                                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        completion(task,nil, error);
                                    }];
    
    return task;
}

@end
