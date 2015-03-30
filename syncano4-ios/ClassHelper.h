//
//  NSObject+PropertyMap.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassHelper : NSObject 

+ (NSDictionary *)propertiesForClass:(Class)class;

@end
