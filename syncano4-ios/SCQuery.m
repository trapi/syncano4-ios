//
//  SCQuery.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCQuery.h"

@interface SCQuery ()
@property (nonatomic,retain) NSString *dataObjectClassName;
@end

@implementation SCQuery
- (instancetype)initWithDataObjectClassName:(NSString *)dataObjectClassName {
    self = [super init];
    if (self) {
        self.dataObjectClassName = dataObjectClassName;
    }
    return self;
}
+ (SCQuery *)queryForDataObjectWithClassName:(NSString *)dataObjectClassName {
    SCQuery *query = [[SCQuery alloc] initWithDataObjectClassName:dataObjectClassName];
    return query;
}
@end
