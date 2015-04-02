//
//  SCDataObject.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCDataObject.h"
#import <Mantle.h>
#import "SCAPIClient.h"
#import "Syncano.h"
#import "SCParseManager.h"
#import "SCQuery.h"

@implementation SCDataObject

+ (NSString *)classNameForAPI {
    return @"DataObject";
}

//This is Mantle method we have to prevent form invoking it form child classes of SCDataObject
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *commonKeysMap = @{@"objectId":@"id"};
    return [commonKeysMap mtl_dictionaryByAddingEntriesFromDictionary:[self extendedPropertiesMapping]];
}

+ (NSDictionary *)extendedPropertiesMapping {
    return @{};
}

+ (SCQuery *)query {
    return [SCQuery queryForDataObjectWithClass:[self class]];
}

- (NSString *)pathForObject {
    NSString *path = [NSString stringWithFormat:@"classes/%@/objects/%@",[[self class] classNameForAPI],self.objectId];
    return path;
}

- (NSURLSessionDataTask *)saveInBackgroundWithCompletionBlock:(SCAPICompletionBlock)completion {
    return [[Syncano sharedAPIClient] postTaskWithPath:[self pathForObject] params:[MTLJSONAdapter JSONDictionaryFromModel:self]  completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        completion(task,responseObject,error);
    }];
}

- (NSURLSessionDataTask *)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCAPICompletionBlock)completion {
    return [[SCAPIClient apiClientForSyncano:syncano] postTaskWithPath:[self pathForObject] params:[MTLJSONAdapter JSONDictionaryFromModel:self]  completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        completion(task,responseObject,error);
    }];
}
@end
