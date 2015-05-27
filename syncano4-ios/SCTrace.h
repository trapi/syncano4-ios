//
//  SCTrace.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 25/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SCTrace : NSObject
@property (nonatomic,copy) NSNumber *identifier;
@property (nonatomic,copy) NSString *status; //TODO: use enum
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSDate *executedAt;
@property (nonatomic,copy) NSDictionary *result;
@property (nonatomic,copy) NSNumber *duration;

- (instancetype)initWithJSONObject:(id)JSONObject;

@end
