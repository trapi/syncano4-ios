//
//  SCQuery.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCDataObject.h"
#import "SCConstants.h"
#import "Syncano.h"

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
 *  FIXME - needs to be redesigned to cover new concept
 *
 *  @param completion completion block
 */
- (void)giveMeDataObjectsInBackgroundWithCompletion:(SCGetDataObjectsCompletionBlock)completion;

@end
