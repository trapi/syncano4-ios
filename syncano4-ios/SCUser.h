//
//  SCUser.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 06/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCUserProfile.h"

@interface SCUser : MTLModel
@property (nonatomic,retain) NSNumber *userId;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *userKey;
@property (nonatomic,retain) SCUserProfile *profile;
@property (nonatomic,retain) NSArray *links;
@end
