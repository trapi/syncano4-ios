//
//  SCQuery.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCConstants.h"

@class Syncano;

/**
 *  Parameter keys for constructing query TODO:Comments for all keys
 */
extern NSString *const SCPleaseParameterLimit;
extern NSString *const SCPleaseParameterFields;
extern NSString *const SCPleaseParameterExcludedFields;
extern NSString *const SCPleaseParameterPageSize;
extern NSString *const SCPleaseParameterOrderByAscending;
extern NSString *const SCPleaseParameterOrderByDescending;

/**
 *  Class to make queries on Syncano API
 */
@interface SCPlease : NSObject

/**
 *  Syncano instance on which queries are made
 */
@property (nonatomic,assign) Syncano *syncano;

/**
 *  Initializes new empty SCPlease object for provided SCDataObject class
 *
 *  @param dataObjectClass SCDataObject scope class
 *
 *  @return SCPlease object
 */
- (instancetype)initWithDataObjectClass:(Class)dataObjectClass;

/**
 *  Creates a new SCPlease object for provided class for singleton Syncano instance.
 *
 *  @param dataObjectClass SCDataObject scope class
 *
 *  @return SCPlease object
 */
+ (SCPlease *)pleaseInstanceForDataObjectWithClass:(Class)dataObjectClass;

/**
 *  Creates a new SCPlease object for provided class for provided Syncano instance
 *
 *  @param dataObjectClass SCDataObject scope class
 *  @param syncano         Syncano instance
 *
 *  @return SCPlease object
 */
+ (SCPlease *)pleaseInstanceForDataObjectWithClass:(Class)dataObjectClass forSyncano:(Syncano *)syncano;


/**
 *  Create and run simple request without any query parameters or statements
 *
 *  @param completion completion block
 */
- (void)giveMeDataObjectsWithCompletion:(SCGetDataObjectsCompletionBlock)completion;

/**
 *  Create and run API request for object with query parameters
 *
 *  @param parameters NSDictionary with query params
 *  @param completion completion block
 */
- (void)giveMeDataObjectsWithParameters:(NSDictionary *)parameters completion:(SCGetDataObjectsCompletionBlock)completion;

/**
 *  Create and run API request for object with query "where is equal to" statement and parameters
 *
 *  @param key        key name to compare
 *  @param object     object that must be equal to key
 *  @param parameters NSDictionary with query params
 *  @param completion completion block
 */
- (void)giveMeDataObjectsWhereKey:(NSString *)key isEqualTo:(id)object parameters:(NSDictionary *)parameters completion:(SCGetDataObjectsCompletionBlock)completion;

@end
