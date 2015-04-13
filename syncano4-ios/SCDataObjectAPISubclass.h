//
//  SCDataObjectAPISubclass.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 08/04/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Protocol used for subclassing SCDataObject
 */
@protocol SCDataObjectAPISubclass <NSObject>
@required
/**
 *  Returns class name used in Syncano API
 *
 *  @return string with API class name
 */
+ (NSString *)classNameForAPI;
@end
