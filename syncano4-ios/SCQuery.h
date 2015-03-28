//
//  SCQuery.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCDataObject.h"

@interface SCQuery : NSObject
- (instancetype)initWithDataObjectClassName:(NSString *)dataObjectClassName;
+ (SCQuery *)queryForDataObjectWithClassName:(NSString *)dataObjectClassName;
@end
