//
//  SCDataObjectAPISubclass.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 08/04/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCDataObjectAPISubclass <NSObject>
@required
+ (NSString *)classNameForAPI;
@end
