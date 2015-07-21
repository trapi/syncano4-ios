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

SPEC_BEGIN(SCPleaseSpec)

describe(@"SCPlease", ^{
    context(@"singleton syncano instance", ^{
        it(@"should fetch objects from API", ^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                return YES;
            } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"Books.json",self.class)
                                                        statusCode:200 headers:@{@"Content-Type":@"application/json"}];
            }];
            __block NSArray *books;
            [[Book please] giveMeDataObjectsWithCompletion:^(NSArray *objects, NSError *error) {
                books = objects;
            }];
            [[books shouldNotEventually] beNil];
        });
    });
});

SPEC_END
