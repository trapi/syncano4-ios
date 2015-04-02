//
//  SCQuery.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCQuery.h"
#import "SCAPIClient+SCDataObject.h"
#import "SCParseManager.h"

@interface SCQuery ()
@property (nonatomic,assign) Class dataObjectClass;
@property (nonatomic,retain) NSString *classNameForAPICalls;
@end

@implementation SCQuery
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
+ (SCQuery *)queryForDataObjectWithClass:dataObjectClass {
    SCQuery *query = [[SCQuery alloc] initWithDataObjectClass:dataObjectClass];
    return query;
}

- (void)getAllDataObjectsInBackgroundWithCompletion:(SCGetDataObjectsCompletionBlock)completion {
    [[SCAPIClient sharedSCAPIClient] getDataObjectsFromClassName:self.classNameForAPICalls params:nil completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (responseObject[@"objects"]) {
            NSArray *responseObjects = responseObject[@"objects"];
            NSMutableArray *parsedObjects = [[NSMutableArray alloc] initWithCapacity:responseObjects.count];
            for (NSDictionary *object in responseObjects) {
                id parsedObject = [SCParseManager parsedObjectOfClass:self.dataObjectClass fromJSONObject:object];
                [parsedObjects addObject:parsedObject];
            }
            completion(parsedObjects,nil);
        } else {
            completion(nil,error);
        }
    }];
}
@end
