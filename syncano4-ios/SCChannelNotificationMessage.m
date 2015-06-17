//
//  SCChannelNotificationMessage.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 08/06/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCChannelNotificationMessage.h"
#import "NSObject+SCParseHelper.h"

@implementation SCChannelNotificationMessage

- (instancetype)initWithJSONObject:(id)JSONObject {
    self = [super init];
    if (self) {
        self.identifier = [JSONObject[@"id"] ph_numberOrNil];
        self.createdAt = [JSONObject[@"createdAt"] ph_dateOrNil];
        self.author = [JSONObject[@"author"] ph_dictionaryOrNil];
        self.action = [SCConstants channelNotificationMessageActionByString:[JSONObject[@"action"] ph_stringOrEmpty]];
        self.payload = [JSONObject[@"payload"] ph_dictionaryOrNil];
        self.metadata = [JSONObject[@"metadata"] ph_dictionaryOrNil];
    }
    return self;
}
@end
