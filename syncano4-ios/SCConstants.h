//
//  SCConstants.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void (^SCAPICompletionBlock)(NSURLSessionDataTask *task, id responseObject, NSError *error);
typedef void (^SCGetDataObjectsCompletionBlock)(NSArray *objects, NSError *error);
typedef void (^SCParseDataObjectsCompletionBlock)(NSArray *objects, NSError *error);
typedef void (^SCParseObjectCompletionBlock)(id parsedObject, NSError *error);
typedef void (^SCCompletionBlock)(BOOL success);


static NSString * const kBaseURL = @"https://syncanotest1-env.elasticbeanstalk.com:443/v1/instances/";