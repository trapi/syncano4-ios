//
//  SCUser.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 06/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//
#import "Syncano.h"
#import "SCUser.h"
#import "SCPlease.h"
#import "SCAPIClient.h"
#import "NSObject+SCParseHelper.h"
#import "SCParseManager+SCUser.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

static NSString *const kCurrentUser = @"com.syncano.kCurrentUser";
static SCUser *_currentUser;

@implementation SCUser

- (NSString *)userKey {
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.syncano"];
    NSString *userKey = [keychain stringForKey:kUserKeyKeychainKey];
    return userKey;
}

+ (SCUser *)currentUser {
    if (_currentUser) {
        return _currentUser;
    }
    id archivedUserData = [self JSONUserDataFromDefaults];
    if (archivedUserData) {
        _currentUser = [[SCParseManager sharedSCParseManager] parsedUserObjectFromJSONObject:archivedUserData];
        return _currentUser;
    }
    return nil;
}

+ (id)JSONUserDataFromDefaults {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUser];
    if (data) {
        id userData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return userData;
    }
    return nil;
}

+ (void)saveJSONUserData:(id)JSONUserData {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:JSONUserData];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(SCCompletionBlock)completion{
    [self loginWithUsername:username password:password usingAPIClient:[Syncano sharedAPIClient] completion:completion];
}

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password toSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion {
    [self loginWithUsername:username password:password usingAPIClient:syncano.apiClient completion:completion];
}

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password usingAPIClient:(SCAPIClient *)apiClient completion:(SCCompletionBlock)completion {
    NSDictionary *params = @{@"username" : username , @"password" : password};
    [apiClient postTaskWithPath:@"user/auth/" params:params completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (error) {
            completion(error);
        } else {
            [self saveJSONUserData:responseObject];
            completion(nil);
        }
    }];
}

+ (void)registerWithUsername:(NSString *)username password:(NSString *)password completion:(SCCompletionBlock)completion {
    [self registerWithUsername:username password:password usingAPIClient:[Syncano sharedAPIClient] completion:completion];
}

+ (void)registerWithUsername:(NSString *)username password:(NSString *)password inSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion {
    [self registerWithUsername:username password:password usingAPIClient:syncano.apiClient completion:completion];
}

+ (void)registerWithUsername:(NSString *)username password:(NSString *)password usingAPIClient:(SCAPIClient *)apiClient completion:(SCCompletionBlock)completion {
    //TODO: validate if username and password are not empty or maybe leave it to API :)
    NSDictionary *params = @{@"username" : username , @"password" : password};
    [apiClient postTaskWithPath:@"users/" params:params completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (error) {
            completion(error);
        } else {
            //TODO: check if after registration we are login in the user and save him to disk
            //[self saveJSONUserData:responseObject];
            completion(nil);
        }
    }];
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.syncano"];
    [keychain removeItemForKey:kUserKeyKeychainKey];
    _currentUser = nil;
}

+ (SCPlease *)please {
    return [SCUserProfile please];
}

+ (SCPlease *)pleaseFromSyncano:(Syncano *)syncano {
    return [SCUser pleaseFromSyncano:syncano];
}

- (void)saveInBackgroundWithCompletionBlock:(SCCompletionBlock)completion {
    [self.profile  saveInBackgroundWithCompletionBlock:completion];
}

- (void)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCCompletionBlock)completion {
    [self.profile saveInBackgroundToSyncano:syncano withCompletion:completion];
}

@end
