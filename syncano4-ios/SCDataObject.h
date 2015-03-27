//
//  SCDataObject.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCDataObject : NSObject
@property (nonatomic,copy) NSNumber *objectId;
@property (nonatomic,copy) NSArray *schema;
@property (nonatomic,copy) NSDate *created_at;
@property (nonatomic,copy) NSDate *updated_at;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *classDescription;
@property (nonatomic,copy) NSArray *links;

+ (NSString *)classNameForAPI;

- (NSURLSessionDataTask *)saveInBackgroundWithCompletionBlock:(SCAPICompletionBlock)completion;

@end
