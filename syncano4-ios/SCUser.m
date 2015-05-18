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

@implementation SCUser

- (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(SCCompletionBlock)completion{
    [self loginWithUsername:username password:password usingAPIClient:[Syncano sharedAPIClient] completion:completion];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password toSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion {
    [self loginWithUsername:username password:password usingAPIClient:syncano.apiClient completion:completion];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password usingAPIClient:(SCAPIClient *)apiClient completion:(SCCompletionBlock)completion {
    NSDictionary *params = @{@"username" : username , @"password" : password};
    [apiClient postTaskWithPath:@"user/auth/" params:params completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (error) {
            completion(error);
        } else {
            [self handleResponseWithResponseObject:responseObject];
            completion(nil);
        }
    }];
}

- (void)registerWithUsername:(NSString *)username password:(NSString *)password completion:(SCCompletionBlock)completion {
    [self registerWithUsername:username password:password usingAPIClient:[Syncano sharedAPIClient] completion:completion];
}

- (void)registerWithUsername:(NSString *)username password:(NSString *)password inSyncano:(Syncano *)syncano completion:(SCCompletionBlock)completion {
    [self registerWithUsername:username password:password usingAPIClient:syncano.apiClient completion:completion];
}

- (void)registerWithUsername:(NSString *)username password:(NSString *)password usingAPIClient:(SCAPIClient *)apiClient completion:(SCCompletionBlock)completion {
    NSDictionary *params = @{@"username" : username , @"password" : password};
    [apiClient postTaskWithPath:@"users/" params:params completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (error) {
            completion(error);
        } else {
            [self handleResponseWithResponseObject:responseObject];
            completion(nil);
        }
    }];
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

- (void)handleResponseWithResponseObject:(id)responseObject {
    self.userId = [responseObject[@"id"] ph_numberOrNil];
    self.username = [responseObject[@"username"] ph_stringOrEmpty];
    self.userKey = [responseObject[@"user_key"] ph_stringOrEmpty];
    self.links = [responseObject[@"links"] ph_arrayOrNil];
    NSDictionary *JSONProfile = [responseObject[@"profile"] ph_dictionaryOrNil];
    if (JSONProfile) {
        SCUserProfile *profile = [[SCParseManager sharedSCParseManager] parsedObjectOfClass:[SCUserProfile class] fromJSONObject:JSONProfile];
        self.profile = profile;
    }
}

@end
