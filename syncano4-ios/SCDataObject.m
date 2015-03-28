//
//  SCDataObject.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCDataObject.h"
#import "SCAPIClient.h"
#import "Syncano.h"

@implementation SCDataObject

+ (NSString *)classNameForAPI {
    return @"DataObject";
}

+ (SCQuery *)query {
    return [SCQuery queryForDataObjectWithClassName:[[self class] classNameForAPI]];
}

//TODO: do the serialization to nsdictionary for API
- (NSDictionary *)serialized {
    return [NSDictionary new];
}

- (NSString *)pathForObject {
    NSString *path = [NSString stringWithFormat:@"classes/%@/objects/%@",[[self class] classNameForAPI],self.objectId];
    return path;
}

- (NSURLSessionDataTask *)saveInBackgroundWithCompletionBlock:(SCAPICompletionBlock)completion {
    return [[SCAPIClient sharedSCAPIClient] postTaskWithPath:[self pathForObject] params:[self serialized]  completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        completion(task,responseObject,error);
    }];
}

- (NSURLSessionDataTask *)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCAPICompletionBlock)completion {
    return [[SCAPIClient apiClientForSyncano:syncano] postTaskWithPath:[self pathForObject] params:[self serialized]  completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        completion(task,responseObject,error);
    }];
}
@end
