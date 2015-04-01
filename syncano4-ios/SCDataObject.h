//
//  SCDataObject.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
@class SCQuery;
@class Syncano;

@interface SCDataObject : MTLModel<MTLJSONSerializing>
@property (nonatomic,copy) NSNumber *objectId;
@property (nonatomic,copy) NSArray *schema;
@property (nonatomic,copy) NSDate *created_at;
@property (nonatomic,copy) NSDate *updated_at;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *classDescription;
@property (nonatomic,copy) NSArray *links;

+ (SCQuery *)query;

+ (NSString *)classNameForAPI;

- (NSURLSessionDataTask *)saveInBackgroundWithCompletionBlock:(SCAPICompletionBlock)completion;
- (NSURLSessionDataTask *)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCAPICompletionBlock)completion;

//No needed while we are using MAntle for parsing objects from and to API
+ (void)registerClass;
@end
