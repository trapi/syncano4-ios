//
//  SCUser.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 06/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCUserProfile.h"

@class SCPlease;

@interface SCUser : MTLModel
@property (nonatomic,retain) NSNumber *userId;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *userKey;
@property (nonatomic,retain) SCUserProfile *profile;
@property (nonatomic,retain) NSArray *links;

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

@end
