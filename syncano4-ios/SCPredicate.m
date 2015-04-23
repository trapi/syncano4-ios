//
//
//  syncano4-ios
//
//  Created by Jan Lipmann on 15/04/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCPredicate.h"

static NSString *const SCPredicateGreaterThanOperator = @"_gt";
static NSString *const SCPredicateGreaterThanOrEqualOperator = @"_gte";
static NSString *const SCPredicateLessThanOperator = @"_lt";
static NSString *const SCPredicateLessThanOrEqualOperator = @"_lte";
static NSString *const SCPredicateEqualOperator = @"_eq";
static NSString *const SCPredicateNotEqualOperator = @"_neq";
static NSString *const SCPredicateExistsOperator = @"_exists";
static NSString *const SCPredicateInOperator = @"_in";


@interface SCPredicate ()
@property (nonatomic,retain) NSString *leftHand;
@property (nonatomic,retain) NSString *operator;
@property (nonatomic,retain) id rightHand;
@end

@implementation SCPredicate

- (instancetype)initWithLeftHand:(NSString *)leftHand operator:(NSString *)operator rightHand:(id)rightHand {
    self = [super init];
    if (self) {
        self.leftHand = leftHand;
        self.operator = operator;
        self.rightHand = rightHand;
    }
    return self;
}

- (NSString *)queryRepresentation {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{self.leftHand : @{self.operator : self.rightHand}}
                                                       options:0
                                                         error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (SCPredicate *)whereKey:(NSString *)key isGreaterThanString:(NSString *)string {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateGreaterThanOperator rightHand:string];
}
+ (SCPredicate *)whereKey:(NSString *)key isGreaterThanNumber:(NSNumber *)number {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateGreaterThanOperator rightHand:number];
}
+ (SCPredicate *)whereKey:(NSString *)key isGreaterThanBool:(BOOL)boolValue {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateGreaterThanOperator rightHand:@(boolValue)];
}
+ (SCPredicate *)whereKey:(NSString *)key isGreaterThanDate:(NSDate *)date {
    //TODO: Here we should use NSDateFormatter to convert Date to proper string
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateGreaterThanOperator rightHand:date];
}

+ (SCPredicate *)whereKey:(NSString *)key isGreaterThanOrEqualToString:(NSString *)string {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateGreaterThanOrEqualOperator rightHand:string];
}
+ (SCPredicate *)whereKey:(NSString *)key isGreaterThanOrEqualToNumber:(NSNumber *)number {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateGreaterThanOrEqualOperator rightHand:number];
}
+ (SCPredicate *)whereKey:(NSString *)key isGreaterThanOrEqualToBool:(BOOL)boolValue {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateGreaterThanOrEqualOperator rightHand:@(boolValue)];
}
+ (SCPredicate *)whereKey:(NSString *)key isGreaterThanOrEqualToDate:(NSDate *)date {
    //TODO: Here we should use NSDateFormatter to convert Date to proper string
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateGreaterThanOrEqualOperator rightHand:date];
}

+ (SCPredicate *)whereKey:(NSString *)key isLessThanString:(NSString *)string {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateLessThanOperator rightHand:string];
}
+ (SCPredicate *)whereKey:(NSString *)key isLessThanNumber:(NSNumber *)number {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateLessThanOperator rightHand:number];
}
+ (SCPredicate *)whereKey:(NSString *)key isLessThanBool:(BOOL)boolValue {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateLessThanOperator rightHand:@(boolValue)];
}
+ (SCPredicate *)whereKey:(NSString *)key isLessThanDate:(NSDate *)date {
    //TODO: Here we should use NSDateFormatter to convert Date to proper string
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateLessThanOperator rightHand:date];
}

+ (SCPredicate *)whereKey:(NSString *)key isLessThanOrEqualToString:(NSString *)string {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateLessThanOrEqualOperator rightHand:string];
}
+ (SCPredicate *)whereKey:(NSString *)key isLessThanOrEqualToNumber:(NSNumber *)number {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateLessThanOrEqualOperator rightHand:number];
}
+ (SCPredicate *)whereKey:(NSString *)key isLessThanOrEqualToBool:(BOOL)boolValue {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateLessThanOrEqualOperator rightHand:@(boolValue)];
}
+ (SCPredicate *)whereKey:(NSString *)key isLessThanOrEqualToDate:(NSDate *)date {
    //TODO: Here we should use NSDateFormatter to convert Date to proper string
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateLessThanOrEqualOperator rightHand:date];
}

+ (SCPredicate *)whereKey:(NSString *)key isEqualToString:(NSString *)string {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateEqualOperator rightHand:string];
}
+ (SCPredicate *)whereKey:(NSString *)key isEqualToNumber:(NSNumber *)number {
   return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateEqualOperator rightHand:number];
}
+ (SCPredicate *)whereKey:(NSString *)key isEqualToBool:(BOOL)boolValue {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateEqualOperator rightHand:@(boolValue)];
}
+ (SCPredicate *)whereKey:(NSString *)key isEqualToDate:(NSDate *)date {
    //TODO: Here we should use NSDateFormatter to convert Date to proper string
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateEqualOperator rightHand:date];
}

+ (SCPredicate *)whereKey:(NSString *)key notEqualToString:(NSString *)string {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateNotEqualOperator rightHand:string];
}
+ (SCPredicate *)whereKey:(NSString *)key notEqualToNumber:(NSNumber *)number {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateNotEqualOperator rightHand:number];
}
+ (SCPredicate *)whereKey:(NSString *)key notEqualToBool:(BOOL)boolValue {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateNotEqualOperator rightHand:@(boolValue)];
}
+ (SCPredicate *)whereKey:(NSString *)key notEqualToDate:(NSDate *)date {
    //TODO: Here we should use NSDateFormatter to convert Date to proper string
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateNotEqualOperator rightHand:date];
}

+ (SCPredicate *)whereKeyExists:(NSString *)key {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateExistsOperator rightHand:@(YES)];
}

+ (SCPredicate *)whereKey:(NSString *)key inArray:(NSArray *)array {
    return [[SCPredicate alloc] initWithLeftHand:key operator:SCPredicateInOperator rightHand:array];
}

@end
