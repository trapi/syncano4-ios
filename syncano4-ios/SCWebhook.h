//
//  SCWebhook.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 28/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCConstants.h"
#import "SCWebhookResponseObject.h"

@class Syncano;

@interface SCWebhook : NSObject


+ (void)runWebhookWithName:(NSString *)name completion:(SCWebhookCompletionBlock)completion;
+ (void)runWebhookWithName:(NSString *)name onSyncano:(Syncano *)syncano completion:(SCWebhookCompletionBlock)completion;
@end
