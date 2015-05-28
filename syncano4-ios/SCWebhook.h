//
//  SCWebhook.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 28/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCConstants.h"

@class Syncano;

@interface SCWebhook : NSObject


+ (void)runWebhookWithSlug:(NSString *)slug completion:(SCWebhookCompletionBlock)completion;
+ (void)runWebhookWithSlug:(NSString *)slug onSyncano:(Syncano *)syncano completion:(SCWebhookCompletionBlock)completion;
@end
