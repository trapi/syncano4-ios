//
//  SCQuery.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCPlease.h"
#import "Syncano.h"
#import "SCAPIClient+SCDataObject.h"
#import "SCParseManager.h"
#import "SCDataObjectAPISubclass.h"
#import "SCPredicate.h"

NSString *const SCPleaseParameterLimit = @"limit";
NSString *const SCPleaseParameterFields = @"fields";
NSString *const SCPleaseParameterExcludedFields = @"exclude_fields";
NSString *const SCPleaseParameterPageSize = @"page_size";
NSString *const SCPleaseParameterOrderBy = @"order_by";
NSString *const SCPleaseParameterIncludeKeys = @"include_keys";


@interface SCPlease ()

/**
 *  Connected SCDataObject Class
 */
@property (nonatomic,assign) Class dataObjectClass;

/**
 *  API class name representation of connected SCDataObject Class
 */
@property (nonatomic,retain) NSString *classNameForAPICalls;

@end

@implementation SCPlease
- (instancetype)initWithDataObjectClass:(Class)dataObjectClass {
    self = [super init];
    if (self) {
        self.dataObjectClass = dataObjectClass;
        if ([dataObjectClass conformsToProtocol:@protocol(SCDataObjectAPISubclass)]) {
            self.classNameForAPICalls = [dataObjectClass classNameForAPI];
        }
    }
    return self;
}
+ (SCPlease *)pleaseInstanceForDataObjectWithClass:dataObjectClass {
    return [self pleaseInstanceForDataObjectWithClass:dataObjectClass forSyncano:nil];
}

+ (SCPlease *)pleaseInstanceForDataObjectWithClass:(Class)dataObjectClass forSyncano:(Syncano *)syncano {
    SCPlease *please = [[SCPlease alloc] initWithDataObjectClass:dataObjectClass];
    if (syncano) {
        please.syncano = syncano;
    }
    return please;
}

/**
 *  Returns proper API Client
 *
 *  @return API Client
 */
- (SCAPIClient *)apiClient {
    if (self.syncano) {
        return self.syncano.apiClient;
    }
    return [Syncano sharedAPIClient];
}

- (void)resolveQueryParameters:(NSDictionary *)parameters withPredicate:(SCPredicate *)predicate completion:(SCPleaseResolveQueryParametersCompletionBlock)completion {
    NSMutableDictionary *queryParameters = (parameters.count > 0) ? [parameters mutableCopy] : [NSMutableDictionary new];
    NSArray *includeKeys;
    if (queryParameters[SCPleaseParameterIncludeKeys]) {
        if ([queryParameters[SCPleaseParameterIncludeKeys] isKindOfClass:[NSArray class]]) {
            includeKeys = queryParameters[SCPleaseParameterIncludeKeys];
        }
        [queryParameters removeObjectForKey:SCPleaseParameterIncludeKeys];
    }
    if (predicate) {
        [queryParameters  addEntriesFromDictionary:@{@"query" : [predicate queryRepresentation]}];
    }
    completion([NSDictionary dictionaryWithDictionary:queryParameters],includeKeys);
}

- (void)giveMeDataObjectsWithCompletion:(SCGetDataObjectsCompletionBlock)completion {
    [self giveMeDataObjectsWithParameters:nil completion:completion];
}

- (void)giveMeDataObjectsWithParameters:(NSDictionary *)parameters completion:(SCGetDataObjectsCompletionBlock)completion {
    [self giveMeDataObjectsWithPredicate:nil parameters:parameters completion:completion];
}

- (void)giveMeDataObjectsWithPredicate:(SCPredicate *)predicate parameters:(NSDictionary *)parameters completion:(SCGetDataObjectsCompletionBlock)completion {
    [self resolveQueryParameters:parameters withPredicate:predicate completion:^(NSDictionary *queryParameters, NSArray *includeKeys) {
        [[self apiClient] getDataObjectsFromClassName:self.classNameForAPICalls params:queryParameters completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
            if (responseObject[@"objects"]) {
                [[SCParseManager sharedSCParseManager] parseObjectsOfClass:self.dataObjectClass fromJSONObject:responseObject[@"objects"] includeKeys:includeKeys completion:^(NSArray *objects, NSError *error) {
                    completion(objects,error);
                }];
            } else {
                completion(nil,error);
            }
        }];
    }];
}
@end
