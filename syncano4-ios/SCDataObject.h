//
//  SCDataObject.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "SCConstants.h"
#import "SCDataObjectAPISubclass.h"

@class Syncano;
@class SCPlease;

/**
 *  Main class for data object from Syncano API.
 */
@interface SCDataObject : MTLModel<MTLJSONSerializing>
@property (nonatomic,copy) NSNumber *objectId;
@property (nonatomic,copy) NSDate *created_at;
@property (nonatomic,copy) NSDate *updated_at;
@property (nonatomic,copy) NSNumber *revision;
@property (nonatomic,copy) NSDictionary *links;

/**
 *  Returns SCPlease instance for singleton Syncano
 *
 *  @return SCPlease instance
 */
+ (SCPlease *)please;

/**
 *  Returns SCPlease instance for provided Syncano instance
 *
 *  @param syncano Syncano instance which SCPlease will be using to query objects from
 *
 *  @return SCPlease instance
 */
+ (SCPlease *)pleaseFromSyncano:(Syncano *)syncano;

/**
 *  Return custom property mapping between iOS class an API class
 *
 *  @return NSDictionary with 'key' of iOS class property name and 'value' with coresponding API class name
 */
+ (NSDictionary *)extendedPropertiesMapping;

/**
 *  Registers class in SCParseManager for proper model parsing.
 */
+ (void)registerClass;

/**
 *  Saves object to API in background for singleton default Syncano instance
 *
 *  @param completion completion block
 *
 */
- (void)saveInBackgroundWithCompletionBlock:(SCCompletionBlock)completion;

/**
 *  Saves object to API in background for chosen Syncano instance
 *
 *  @param syncano    Saves object to API in background for provided Syncano instance
 *  @param completion completion block
 *
 */
- (void)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCCompletionBlock)completion;

/**
 *  Fetches object from API using singleton Syncano instance
 *
 *  @param completion comletion block
 */
- (void)fetchWithCompletion:(SCCompletionBlock)completion;

/**
 *  Fetches object from API using provided Syncano instance
 *
 *  @param syncano    provided Syncano instance
 *  @param completion completion block
 */
- (void)fetchFromSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion;

- (void)deleteWithCompletion:(SCCompletionBlock)completion;
- (void)deleteFromSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion;
@end
