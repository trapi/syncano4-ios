//
//  SCJSONResponseSerializer.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 16/06/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCJSONResponseSerializer.h"

@implementation SCJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    if (*error != nil) {
        NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
        if (data == nil) {
            //			// NOTE: You might want to convert data to a string here too, up to you.
            //			userInfo[JSONResponseSerializerWithDataKey] = @"";
            userInfo[kSyncanoRepsonseErrorKey] = [NSDictionary new];//[NSData data];
        } else {
            //			// NOTE: You might want to convert data to a string here too, up to you.
            //			userInfo[JSONResponseSerializerWithDataKey] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            userInfo[kSyncanoRepsonseErrorKey] = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]; //data;
        }
        NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
        (*error) = newError;
    }
    return (JSONObject);
}

@end
