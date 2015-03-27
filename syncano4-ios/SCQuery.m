//
//  SCQuery.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCQuery.h"

@interface SCQuery ()
@property (nonatomic,retain) SCDataObject *dataObject;
@end

@implementation SCQuery
- (instancetype)initWithDataObject:(SCDataObject *)dataObject {
    self = [super init];
    if (self) {
        self.dataObject = dataObject;
    }
    return self;
}
+ (SCQuery *)queryForDataObject:(SCDataObject *)dataObject {
    SCQuery *query = [[SCQuery alloc] initWithDataObject:dataObject];
    return query;
}
@end
