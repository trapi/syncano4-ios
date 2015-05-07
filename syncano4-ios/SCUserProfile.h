//
//  SCUserProfile.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 07/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCUserProfile : NSObject
@property (nonatomic,retain) NSNumber *profileId;
@property (nonatomic,retain) NSDate *created_at;
@property (nonatomic,retain) NSDate *updated_at;
@property (nonatomic,retain) NSNumber *revision;
@property (nonatomic,retain) NSNumber *owner;
@end
