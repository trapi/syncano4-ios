//
//  NSObject+SCParseHelper.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 12/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "NSObject+SCParseHelper.h"

@implementation NSObject (SCParseHelper)
- (NSString *)ph_stringOrEmpty {
    if ([self isKindOfClass:[NSString class]] && (self != [NSNull null])) {
        return (NSString *)self;
    } else {
        return  nil;
    }
}
- (NSNumber *)ph_numberOrNil {
    if ([self isKindOfClass:[NSNumber class]] && (self != [NSNull null])) {
        return (NSNumber *)self;
    } else {
        return  nil;
    }
}
- (NSArray *)ph_arrayOrNil {
    if ([self isKindOfClass:[NSArray class]] && (self != [NSNull null])) {
        return (NSArray *)self;
    } else {
        return  nil;
    }
}

- (NSDictionary *)ph_dictionaryOrNil {
    if ([self isKindOfClass:[NSDictionary class]] && (self != [NSNull null])) {
        return (NSDictionary *)self;
    } else {
        return  nil;
    }
}

- (NSDate *)ph_dateOrNil {
    if ([self isKindOfClass:[NSDate class]] && (self != [NSNull null])) {
        return (NSDate *)self;
    } else {
        return  nil;
    }
}
@end
