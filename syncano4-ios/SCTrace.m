//
//  SCTrace.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 25/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCTrace.h"
#import "NSObject+SCParseHelper.h"

@implementation SCTrace

- (instancetype)initWithJSONObject:(id)JSONObject {
    self = [super init];
    if (self) {
        self.identifier = [JSONObject[@"id"] ph_numberOrNil];
        self.status = [JSONObject[@"status"] ph_stringOrEmpty];
        self.links = [JSONObject[@"links"] ph_dictionaryOrNil];
        self.executedAt = [JSONObject[@"executed_at"] ph_dateOrNil];
        self.result = [JSONObject[@"result"] ph_dictionaryOrNil];
        self.duration = [JSONObject[@"duration"] ph_numberOrNil];
    }
    return self;
}

@end
