//
//  SCAPIClient.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^SCAPICompletionBlock)(NSURLSessionDataTask *task, id responseObject, NSError *error);

@interface SCAPIClient : AFHTTPSessionManager
AUSINGLETON_FOR_CLASS(SCAPIClient);
@end
