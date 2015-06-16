//
//  SCChannel.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 03/06/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCConstants.h"
#import "SCChannelDelegate.h"

@class Syncano;

@interface SCChannel : NSObject

@property (nonatomic,retain)    NSString *name;
@property (nonatomic)           SCChannelType type;
@property (nonatomic)           BOOL customPublish;
@property (nonatomic,retain)    NSDictionary *links;
@property (nonatomic,retain)    NSDate *createdAt;
@property (nonatomic,retain)    NSDate *updatedAt;
@property (nonatomic)           SCChannelPermisionType groupPermissions;
@property (nonatomic)           SCChannelPermisionType otherPermissions;
@property (nonatomic,retain)    NSNumber *group;

@property (nonatomic,assign) id<SCChannelDelegate> delegate;

- (instancetype)initWithName:(NSString *)channelName;

- (instancetype)initWithName:(NSString *)channelName andDelegate:(id<SCChannelDelegate>)delegate;

- (void)subscribeToChannel;
- (void)subscribeToChannelInSyncano:(Syncano *)syncano;

@end
