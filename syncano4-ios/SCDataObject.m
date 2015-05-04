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
    if (self.links[@"self"]) {
        return self.links[@"self"];
    }
    NSString *path;
    if (self.objectId) {
        path = [NSString stringWithFormat:@"classes/%@/objects/%@/",[[self class] classNameForAPI],self.objectId];
    } else {
        path = [NSString stringWithFormat:@"classes/%@/objects/",[[self class] classNameForAPI]];
    }
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
        [[SCParseManager sharedSCParseManager] updateObject:self withDataFromJSONObject:responseObject];
        completion(error);
    }];
}

- (void)saveInBackgroundWithCompletionBlock:(SCCompletionBlock)completion {
    [self saveInBackgroundUsingAPIClient:[Syncano sharedAPIClient] withCompletion:completion];
}

- (void)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCCompletionBlock)completion {
    [self saveInBackgroundUsingAPIClient:syncano.apiClient withCompletion:completion];
}

- (void)saveInBackgroundUsingAPIClient:(SCAPIClient *)apiClient withCompletion:(SCCompletionBlock)completion {
    [self handleRelationsSaveUsingAPIClient:apiClient withCompletion:^() {
        NSError *error;
        NSDictionary *params = [[SCParseManager sharedSCParseManager] JSONSerializedDictionaryFromDataObject:self error:&error];
        if (error) {
            completion(error);
            
        } else {
            [apiClient postTaskWithPath:[self pathForObject] params:params  completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
                [[SCParseManager sharedSCParseManager] updateObject:self withDataFromJSONObject:responseObject];
                completion(error);
            }];
        }

    }];
}

- (void)handleRelationsSaveUsingAPIClient:(SCAPIClient *)apiClient withCompletion:(void(^)())completion {
    NSDictionary *relations = [[SCParseManager sharedSCParseManager] relationsForClass:[self class]];
    if (relations.count > 0) {
        dispatch_group_t relationSaveGroup = dispatch_group_create();
        for (NSString *propertyName in relations.allKeys) {
            SCDataObject *relatedObject = [self valueForKey:propertyName];
            if ([relatedObject isKindOfClass:[SCDataObject class]]) {
                if (!relatedObject.objectId) {
                    dispatch_group_enter(relationSaveGroup);
                    [relatedObject saveInBackgroundUsingAPIClient:apiClient withCompletion:^(NSError *error) {
                        [self setValue:relatedObject forKey:propertyName];
                        dispatch_group_leave(relationSaveGroup);
                    }];
                }
            }
        }
        dispatch_group_notify(relationSaveGroup, dispatch_get_main_queue(), ^{
            completion();
        });
    } else {
        completion();
    }
}
@end
