//
//  SCQuery.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCPlease.h"
#import "SCAPIClient+SCDataObject.h"
#import "SCParseManager.h"

@interface SCPlease ()
@property (nonatomic,assign) Class dataObjectClass;
@property (nonatomic,retain) NSString *classNameForAPICalls;
@end

@implementation SCPlease
- (instancetype)initWithDataObjectClass:(Class)dataObjectClass {
    self = [super init];
    if (self) {
        self.dataObjectClass = dataObjectClass;
        if ([dataObjectClass respondsToSelector:@selector(classNameForAPI)]) {
            self.classNameForAPICalls = [dataObjectClass classNameForAPI];
        }
    }
    return self;
}
+ (SCPlease *)pleaseInstanceForDataObjectWithClass:dataObjectClass {
    return [self pleaseInstanceForDataObjectWithClass:dataObjectClass forSyncano:nil];
}

+ (SCPlease *)pleaseInstanceForDataObjectWithClass:(Class)dataObjectClass forSyncano:(Syncano *)syncano {
    SCPlease *query = [[SCPlease alloc] initWithDataObjectClass:dataObjectClass];
    if (syncano) {
        query.syncano = syncano;
    }
    return query;
}

- (SCAPIClient *)apiClient {
    if (self.syncano) {
        return self.syncano.apiClient;
    }
    return [Syncano sharedAPIClient];
}

- (void)giveMeDataObjectsInBackgroundWithCompletion:(SCGetDataObjectsCompletionBlock)completion {
    [[self apiClient] getDataObjectsFromClassName:self.classNameForAPICalls params:nil completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (responseObject[@"objects"]) {
            NSArray *responseObjects = responseObject[@"objects"];
            NSMutableArray *parsedObjects = [[NSMutableArray alloc] initWithCapacity:responseObjects.count];
            for (NSDictionary *object in responseObjects) {
                id parsedObject = [[SCParseManager sharedSCParseManager] parsedObjectOfClass:self.dataObjectClass fromJSONObject:object];
                [parsedObjects addObject:parsedObject];
            }
            completion(parsedObjects,nil);
        } else {
            completion(nil,error);
        }
    }];
}
@end
