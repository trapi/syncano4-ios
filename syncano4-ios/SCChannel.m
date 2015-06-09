//
//  SCChannel.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 03/06/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCChannel.h"
#import "Syncano.h"
#import "SCAPIClient.h"
#import "SCChannelNotificationMessage.h"

@implementation SCChannel

- (instancetype)initWithName:(NSString *)channelName {
    return [self initWithName:channelName andDelegate:nil];
}

- (instancetype)initWithName:(NSString *)channelName andDelegate:(id<SCChannelDelegate>)delegate {
    self = [super init];
    if (self) {
        self.name = channelName;
        self.delegate = delegate;
    }
    return self;
}

- (void)subscribeToChannel {
    [self subscribeToChannelUsingAPIClient:[Syncano sharedAPIClient]];
}
- (void)subscribeToChannelInSyncano:(Syncano *)syncano {
    [self subscribeToChannelUsingAPIClient:syncano.apiClient];
}

- (void)subscribeToChannelUsingAPIClient:(SCAPIClient *)apiClient {
    [self pollToChannelUsingAPIClient:apiClient withLastId:nil];
}

- (void)pollToChannelUsingAPIClient:(SCAPIClient *)apiClient withLastId:(NSNumber *)lastId {
    NSString *path = [NSString stringWithFormat:@"channels/%@/poll/",self.name];
    NSDictionary *params = (lastId) ? @{@"last_id" : lastId} : nil;
    [apiClient getTaskWithPath:path params:params completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            SCChannelNotificationMessage *message = [[SCChannelNotificationMessage alloc] initWithJSONObject:responseObject];
            if ([self.delegate respondsToSelector:@selector(chanellDidReceivedNotificationMessage:)]) {
                [self.delegate chanellDidReceivedNotificationMessage:message];
            }
            [self pollToChannelUsingAPIClient:apiClient withLastId:message.identifier];
        }
    }];
}

@end
