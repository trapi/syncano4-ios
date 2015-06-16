//
//  SCJSONResponseSerializer.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 16/06/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "AFURLResponseSerialization.h"

static NSString * const kSyncanoRepsonseErrorKey = @"com.Syncano.responseErrorDetailsKey";


@interface SCJSONResponseSerializer : AFJSONResponseSerializer

@end
