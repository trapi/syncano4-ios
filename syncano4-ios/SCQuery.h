//
//  SCQuery.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCDataObject.h"
#import "SCConstants.h"
#import "Syncano.h"

@interface SCQuery : NSObject
@property (nonatomic,assign) Syncano *syncano;
- (instancetype)initWithDataObjectClass:(Class)dataObjectClass;
+ (SCQuery *)queryForDataObjectWithClass:(Class)dataObjectClass;
+ (SCQuery *)queryForDataObjectWithClass:(Class)dataObjectClass forSyncano:(Syncano *)syncano;

- (void)getDataObjectsInBackgroundWithCompletion:(SCGetDataObjectsCompletionBlock)completion;

@end
