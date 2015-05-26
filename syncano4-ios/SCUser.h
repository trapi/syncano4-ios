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
@property (nonatomic,readonly) NSString *userKey;
@property (nonatomic,retain) SCUserProfile *profile;
@property (nonatomic,retain) NSDictionary *links;


/**
 *  Attempts to get the currently logged in user from disk and returns an instance of it.
 *
 *  @return SCUser instance of currently logged in user or nil
 */
+ (SCUser *)currentUser;

+ (void)registerProfileClass:(__unsafe_unretained Class)userProfileClass;

/**
 *  Attempts to login user into singleton Syncano
 *
 *  @param username   username for login
 *  @param password   password for login
 *  @param completion completion block
 */
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(SCCompletionBlock)completion;

/**
 *  Attempts to login user into provided Syncano instance
 *
 *  @param username   username for login
 *  @param password   password for login
 *  @param syncano    syncano instance for login in to
 *  @param completion completion block
 */
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password toSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion;

/**
 *  Attempts to register user into singleton Syncano
 *
 *  @param username   username for login
 *  @param password   password for login
 *  @param completion completion block
 */
+ (void)registerWithUsername:(NSString *)username password:(NSString *)password completion:(SCCompletionBlock)completion;

/**
 *  Attempts to register user into provided Syncano instance
 *
 *  @param username   username for login
 *  @param password   password for login
 *  @param syncano    syncano instance for login in to
 *  @param completion completion block
 */
+ (void)registerWithUsername:(NSString *)username password:(NSString *)password inSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion;

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


- (void)logout;

/**
 *  Saves object to API in background for singleton default Syncano instance
 *
 *  @param completion completion block
 *
 */
- (void)saveWithCompletionBlock:(SCCompletionBlock)completion;


/**
 *  Saves object to API in background for chosen Syncano instance
 *
 *  @param syncano    Saves object to API in background for provided Syncano instance
 *  @param completion completion block
 *
 */
- (void)saveToSyncano:(Syncano *)syncano withCompletion:(SCCompletionBlock)completion;


- (void)updateValue:(id)value forKey:(NSString *)key withCompletion:(SCCompletionBlock)completion;
- (void)updateValue:(id)value forKey:(NSString *)key inSyncno:(Syncano *)syncano withCompletion:(SCCompletionBlock)completion;
@end
