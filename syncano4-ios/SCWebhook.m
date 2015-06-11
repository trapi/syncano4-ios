//
//  SCWebhook.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 28/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCWebhook.h"
#import "SCAPIClient.h"
#import "Syncano.h"
#import "SCWebhookResponseObject.h"

@implementation SCWebhook

+ (void)runWebhookWithName:(NSString *)name completion:(SCWebhookCompletionBlock)completion {
    [self runWebhookWithName:name usingAPIClient:[Syncano sharedAPIClient] completion:completion];
}
+ (void)runWebhookWithName:(NSString *)name onSyncano:(Syncano *)syncano completion:(SCWebhookCompletionBlock)completion {
    [self runWebhookWithName:name usingAPIClient:syncano.apiClient completion:completion];
}
+ (void)runWebhookWithName:(NSString *)name usingAPIClient:(SCAPIClient *)apiClient completion:(SCWebhookCompletionBlock)completion {
    NSString *path = [NSString stringWithFormat:@"webhooks/%@/run/",name];
   [apiClient postTaskWithPath:path params:nil completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
       if (error) {
           if (completion) {
               completion(nil,error);
           }
       } else {
           if (completion) {
               SCWebhookResponseObject *webhookResponseObject = [[SCWebhookResponseObject alloc] initWithJSONObject:responseObject];
               completion(webhookResponseObject,nil);
           }
       }
   }];
}

@end
