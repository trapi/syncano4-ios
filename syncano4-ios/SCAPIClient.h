//
//  SCAPIClient.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "AFHTTPSessionManager.h"
@interface SCAPIClient : AFHTTPSessionManager

AUSINGLETON_FOR_CLASS(SCAPIClient);

- (NSURLSessionDataTask *)getTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion;
- (NSURLSessionDataTask *)postTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion;
- (NSURLSessionDataTask *)putTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion;
- (NSURLSessionDataTask *)deleteTaskWithPath:(NSString *)path params:(NSDictionary *)params completion:(SCAPICompletionBlock)completion;
@end
