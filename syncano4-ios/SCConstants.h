//
//  SCConstants.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//
#import <Foundation/Foundation.h>

@class SCTrace;
@class SCWebhookResponseObject;
@class SCChannelNotificationMessage;

typedef void (^SCAPICompletionBlock)(NSURLSessionDataTask *task, id responseObject, NSError *error);
typedef void (^SCDataObjectsCompletionBlock)(NSArray *objects, NSError *error);
typedef void (^SCParseObjectCompletionBlock)(id parsedObject, NSError *error);
typedef void (^SCCompletionBlock)(NSError *error);
typedef void (^SCCodeBoxCompletionBlock)(SCTrace *trace,NSError *error);
typedef void (^SCTraceCompletionBlock)(id result, NSError *error);
typedef void (^SCWebhookCompletionBlock)(SCWebhookResponseObject *responseObject,NSError *error);
typedef void (^SCPleaseResolveQueryParametersCompletionBlock)(NSDictionary *queryParameters,NSArray *includeKeys);
typedef void (^SCChannelPollCallbackBlock)(SCChannelNotificationMessage *notificationMessage);


static NSString * const kBaseURL = @"https://api.syncano.rocks/v1/instances/";
static NSString * const kUserKeyKeychainKey = @"com.syncano.kUserKeyKeychain";
