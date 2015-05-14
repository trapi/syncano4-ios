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

@implementation SCUser

+ (SCPlease *)please {
    return [SCPlease pleaseInstanceForUserClass];
}

+ (SCPlease *)pleaseFromSyncano:(Syncano *)syncano {
    return [SCPlease pleaseInstanceForUserClassForSyncano:syncano];
}

- (void)saveInBackgroundWithCompletionBlock:(SCCompletionBlock)completion {
    [self saveInBackgroundUsingAPIClient:[Syncano sharedAPIClient] withCompletion:completion];
}

- (void)saveInBackgroundToSyncano:(Syncano *)syncano withCompletion:(SCCompletionBlock)completion {
    [self saveInBackgroundUsingAPIClient:syncano.apiClient withCompletion:completion];
}

- (void)saveInBackgroundUsingAPIClient:(SCAPIClient *)apiClient withCompletion:(SCCompletionBlock)completion {
    //TODO: Here we have to save User first then save profile
}

@end
