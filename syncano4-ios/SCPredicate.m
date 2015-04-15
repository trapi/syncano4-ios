//
//
//  syncano4-ios
//
//  Created by Jan Lipmann on 15/04/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCPredicate.h"

static NSString *const SCPredicateEqualOperator = @"_eq";

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

- (NSDictionary *)queryRepresentation {
   return @{self.leftHand : @{self.operator : self.rightHand}};
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

@end
