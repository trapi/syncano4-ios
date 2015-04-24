//
//  SCPredicateSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 24/04/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "SCPredicate.h"

SPEC_BEGIN(SCPredicateSpec)
describe(@"SCpredicate", ^{
    
    __block SCPredicate *predicate;
    __block NSString *expectedQuery;
    __block NSString *queryRepresentation;
    __block NSDate *date;
    __block NSDateFormatter *dateFormatter;
    
    beforeAll(^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
        date = [NSDate date];
    });
    
    //Greater
    it(@"should generate query greater than string statement", ^{
        predicate = [SCPredicate whereKey:@"left" isGreaterThanString:@"right"];
        expectedQuery = @"{\"left\":{\"_gt\":\"right\"}}";
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
    it(@"should generate query greater than number statement", ^{
        predicate = [SCPredicate whereKey:@"left" isGreaterThanNumber:@(1)];
        expectedQuery = @"{\"left\":{\"_gt\":1}}";
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
    it(@"should generate query greater than date statement", ^{
        predicate = [SCPredicate whereKey:@"left" isGreaterThanDate:date];
        expectedQuery = [NSString stringWithFormat:@"{\"left\":{\"_gt\":\"%@\"}}",[dateFormatter stringFromDate:date]];
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
    
    
    //Equal
    it(@"should generate query equal to number statement", ^{
        predicate = [SCPredicate whereKey:@"left" isEqualToNumber:@(1)];
        expectedQuery = @"{\"left\":{\"_eq\":1}}";;
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
    
    it(@"should generate query equal to bool statement", ^{
        predicate = [SCPredicate whereKey:@"left" isEqualToBool:YES];
        expectedQuery = @"{\"left\":{\"_eq\":true}}";;
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
    
    it(@"should generate query equal to date statement", ^{
        predicate = [SCPredicate whereKey:@"left" isEqualToDate:date];
        expectedQuery = [NSString stringWithFormat:@"{\"left\":{\"_eq\":\"%@\"}}",[dateFormatter stringFromDate:date]];
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });

    
    
    
    it(@"should generate query equal to string statement", ^{
        predicate = [SCPredicate whereKey:@"left" isEqualToString:@"right"];
        expectedQuery = @"{\"left\":{\"_eq\":\"right\"}}";
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
    
    it(@"should generate query equal to number statement", ^{
        predicate = [SCPredicate whereKey:@"left" isEqualToNumber:@(1)];
        expectedQuery = @"{\"left\":{\"_eq\":1}}";;
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
    
    it(@"should generate query equal to bool statement", ^{
        predicate = [SCPredicate whereKey:@"left" isEqualToBool:YES];
        expectedQuery = @"{\"left\":{\"_eq\":true}}";;
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
    
    it(@"should generate query equal to date statement", ^{
        predicate = [SCPredicate whereKey:@"left" isEqualToDate:date];
        expectedQuery = [NSString stringWithFormat:@"{\"left\":{\"_eq\":\"%@\"}}",[dateFormatter stringFromDate:date]];
        queryRepresentation = [predicate queryRepresentation];
        [[queryRepresentation should] equal:expectedQuery];
    });
});


SPEC_END
