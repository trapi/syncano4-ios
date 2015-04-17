//
//  SCDataObject.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCDataObject.h"
#import <Mantle.h>
#import "SCAPIClient+SCDataObject.h"
#import "Syncano.h"
#import "SCParseManager.h"
#import "SCDataObjectAPISubclass.h"
#import "SCPlease.h"

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

+ (void)registerClass {
    if ([[self class] conformsToProtocol:@protocol(SCDataObjectAPISubclass)]) {
        [[SCParseManager sharedSCParseManager] registerClass:[self class]];
    }
}

+ (SCPlease *)please {
    return [SCPlease pleaseInstanceForDataObjectWithClass:[self class]];
}

+ (SCPlease *)pleaseFromSyncano:(Syncano *)syncano {
    return [SCPlease pleaseInstanceForDataObjectWithClass:[self class] forSyncano:syncano];
}

- (NSString *)pathForObject {
    NSString *path = [NSString stringWithFormat:@"classes/%@/objects/%@",[[self class] classNameForAPI],self.objectId];
    return path;
}

- (void)fetchWithCompletion:(SCCompletionBlock)completion {
    [self fetchUsingAPIClient:[Syncano sharedAPIClient] completion:completion];
}

- (void)fetchFromSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion {
    [self fetchUsingAPIClient:syncano.apiClient completion:completion];
}

- (void)fetchUsingAPIClient:(SCAPIClient *)apiClient completion:(SCCompletionBlock)completion {
    [apiClient getDataObjectsFromClassName:[[self class] classNameForAPI] withId:self.objectId completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        //TODO fill object with new data
        completion(YES);
    }];
}

- (NSURLSessionDataTask *)saveInBackgroundWithCompletionBlock:(SCAPICompletionBlock)completion {
    return [[Syncano sharedAPIClient] postTaskWithPath:[self pathForObject] params:[MTLJSONAdapter JSONDictionaryFromModel:self]  completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        completion(task,responseObject,error);
    }];
}

- (NSURLSessionDataTask *)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCAPICompletionBlock)completion {
    return [syncano.apiClient postTaskWithPath:[self pathForObject] params:[MTLJSONAdapter JSONDictionaryFromModel:self]  completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        completion(task,responseObject,error);
    }];
}
@end
