//
//  SCParseManager+SCUser.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 07/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCParseManager+SCUser.h"
#import "SCParseManager+SCDataObject.h"
#import "SCUser.h"
#import "NSObject+SCParseHelper.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@implementation SCParseManager (SCUser)
- (SCUser *)parsedUserObjectFromJSONObject:(id)JSONObject {
    SCUser *user = [SCUser new];
    user.userId = [JSONObject[@"id"] ph_numberOrNil];
    user.username = [JSONObject[@"username"] ph_stringOrEmpty];
    user.links = [JSONObject[@"links"] ph_dictionaryOrNil];
    NSDictionary *JSONProfile = [JSONObject[@"profile"] ph_dictionaryOrNil];
    if (JSONProfile) {
        SCUserProfile *profile = [self parsedObjectOfClass:[SCUserProfile class] fromJSONObject:JSONProfile];
        user.profile = profile;
    }
    NSString *userKey = [JSONObject[@"user_key"] ph_stringOrEmpty];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.syncano"];
    keychain[kUserKeyKeychainKey] = userKey;
    return user;
}
@end
