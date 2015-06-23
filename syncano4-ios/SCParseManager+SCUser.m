//
//  SCParseManager+SCUser.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 07/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <objc/runtime.h>
#import "SCParseManager+SCUser.h"
#import "SCParseManager+SCDataObject.h"
#import "SCUser.h"
#import "NSObject+SCParseHelper.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

@implementation SCParseManager (SCUser)


- (void)setUserProfileClass:(__unsafe_unretained Class)userProfileClass {
    objc_setAssociatedObject(self, @selector(userProfileClass), userProfileClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (__unsafe_unretained Class)userProfileClass {
    return objc_getAssociatedObject(self, @selector(userProfileClass));
}

- (void)registerUserProfileClass:(__unsafe_unretained Class)classToRegister {
    [self setUserProfileClass:classToRegister];
}

- (SCUser *)parsedUserObjectFromJSONObject:(id)JSONObject {
    SCUser *user = [SCUser new];
    user.userId = [JSONObject[@"id"] sc_numberOrNil];
    user.username = [JSONObject[@"username"] sc_stringOrEmpty];
    user.links = [JSONObject[@"links"] sc_dictionaryOrNil];
    NSDictionary *JSONProfile = [JSONObject[@"profile"] sc_dictionaryOrNil];
    if (JSONProfile) {
        Class UserProfileClass = ([self userProfileClass]) ? [self userProfileClass] : [SCUserProfile class];
        id profile = [self parsedObjectOfClass:(self.userProfileClass) ? self.userProfileClass : UserProfileClass fromJSONObject:JSONProfile];
        user.profile = profile;
    }
    NSString *userKey = [JSONObject[@"user_key"] sc_stringOrEmpty];
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"com.syncano"];
    keychain[kUserKeyKeychainKey] = userKey;
    return user;
}
@end
