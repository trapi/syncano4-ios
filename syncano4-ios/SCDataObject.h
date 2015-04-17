//
//  SCDataObject.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import  "SCConstants.h"
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
@property (nonatomic,copy) NSArray *links;

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
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)saveInBackgroundWithCompletionBlock:(SCAPICompletionBlock)completion;

/**
 *  <#Description#>
 *
 *  @param syncano    Saves object to API in background for provided Syncano instance
 *  @param completion completion block
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCAPICompletionBlock)completion;


- (void)fetchWithCompletion:(SCCompletionBlock)completion;
- (void)fetchFromSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion;
@end
