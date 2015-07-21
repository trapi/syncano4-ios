//
//  SCDataObjectSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "Syncano.h"
#import "Book.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

SPEC_BEGIN(SCParseManagerSpec)

describe(@"SCParseManager", ^{
    
    it(@"should create object from JSON NSDictionary", ^{
        NSError *error;
        NSDictionary *JSON = @{@"id" : @123,};
        SCDataObject *dataObject = [MTLJSONAdapter modelOfClass:[SCDataObject class] fromJSONDictionary:JSON error:&error];
        [[error should] beNil];
        [[dataObject.objectId should] equal:@123];
    });

});

SPEC_END
