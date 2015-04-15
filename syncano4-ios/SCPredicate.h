//
//  SCPredicate.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 15/04/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Class
 */
@interface SCPredicate : NSObject

+ (SCPredicate *)whereKey:(NSString *)key isEqualToString:(NSString *)string;
+ (SCPredicate *)whereKey:(NSString *)key isEqualToNumber:(NSNumber *)number;
+ (SCPredicate *)whereKey:(NSString *)key isEqualToBool:(BOOL)boolValue;
+ (SCPredicate *)whereKey:(NSString *)key isEqualToDate:(NSDate *)date;

- (NSString *)queryRepresentation;

@end
