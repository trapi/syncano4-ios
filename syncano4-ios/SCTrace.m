//
//  SCTrace.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 25/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCTrace.h"
#import "NSObject+SCParseHelper.h"
#import "Syncano.h"
#import "SCAPIClient.h"

@implementation SCTrace

- (instancetype)initWithJSONObject:(id)JSONObject {
    self = [super init];
    if (self) {
        self.identifier = [JSONObject[@"id"] ph_numberOrNil];
        self.status = [JSONObject[@"status"] ph_stringOrEmpty];
        self.links = [JSONObject[@"links"] ph_dictionaryOrNil];
        self.executedAt = [JSONObject[@"executed_at"] ph_dateOrNil];
        self.result = [JSONObject[@"result"] ph_dictionaryOrNil];
        self.duration = [JSONObject[@"duration"] ph_numberOrNil];
    }
    return self;
}

- (void)callWithCompletion:(SCTraceCompletionBlock)completion {
    [self callUsingAPIClient:[Syncano sharedAPIClient] withCompletion:completion];
}

- (void)callOnSyncano:(Syncano *)syncano withCompletion:(SCTraceCompletionBlock)completion {
    [self callUsingAPIClient:syncano.apiClient withCompletion:completion];
}

- (void)callUsingAPIClient:(SCAPIClient *)apiClient withCompletion:(SCTraceCompletionBlock)completion {
    NSString *path = [NSString stringWithFormat:@"codeboxes/%@/run/",self.identifier];
    [apiClient postTaskWithPath:path params:nil completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject,error);
        }
    }];
}

@end
