//
//  SCCannedURLProtocol.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 14/07/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCAPIClient.h"

@interface SCCannedURLProtocol : NSURLProtocol <NSURLSessionDataDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionTask *task;

+ (void)setCannedResponseData:(NSData*)data;
+ (void)setCannedHeaders:(NSDictionary*)headers;
+ (void)setCannedStatusCode:(NSInteger)statusCode;
+ (void)setCannedError:(NSError*)error;

+ (void)registerInAPIClient:(SCAPIClient *)apiClient;
+ (void)unregisterFromAPIClient:(SCAPIClient *)apiClient;
@end
