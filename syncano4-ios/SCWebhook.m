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

+ (void)runWebhookWithSlug:(NSString *)slug completion:(SCWebhookCompletionBlock)completion {
    [self runWebhookWithSlug:slug usingAPIClient:[Syncano sharedAPIClient] completion:completion];
}
+ (void)runWebhookWithSlug:(NSString *)slug onSyncano:(Syncano *)syncano completion:(SCWebhookCompletionBlock)completion {
    [self runWebhookWithSlug:slug usingAPIClient:syncano.apiClient completion:completion];
}
+ (void)runWebhookWithSlug:(NSString *)slug usingAPIClient:(SCAPIClient *)apiClient completion:(SCWebhookCompletionBlock)completion {
    NSString *path = [NSString stringWithFormat:@"/webhooks/%@/run/",slug];
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
