//
//  SCUserSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 6/07/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "SCUser.h"
#import "KWSpec+WaitFor.h"
#import "Syncano.h"
#import <OHHTTPStubs.h>

SPEC_BEGIN(SCUserSpec)

describe(@"SCUser", ^{
    
    context(@"custom syncano instance", ^{
        Syncano *syncano = [[Syncano alloc] initWithApiKey:@"API-KEY" instanceName:@"INSTANCE-NAME"];
        
        it(@"should register", ^{
            
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                return YES;
            } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                // Stub it with our "wsresponse.json" stub file
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"SCUserRegister_200.json",self.class)
                                                        statusCode:200 headers:@{@"Content-Type":@"application/json"}];
            }];
            
            __block NSError *_error;
            __block BOOL _blockFinished;
            __block SCUser *registereddUser;
            [SCUser registerWithUsername:@"zenon" password:@"rtw57hwggwt6" inSyncano:syncano completion:^(NSError *error) {
                _error = error;
                _blockFinished = YES;
                registereddUser = [SCUser currentUser];
                //[SCCannedURLProtocol unregisterFromAPIClient:syncano.apiClient];

            }];
            [[expectFutureValue(theValue(_blockFinished)) shouldEventually] beYes];
            [[_error shouldEventually] beNil];
            [[registereddUser shouldEventually] beNonNil];
        });
        
        
        
        it(@"should login and logout", ^{
            
            //Login
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                return YES;
            } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"SCUserLogin_200.json",self.class)
                                                        statusCode:200 headers:@{@"Content-Type":@"application/json"}];
            }];
            
            __block SCUser *loggedUser;
            __block NSError *_error;
            __block BOOL _blockFinished;
            [SCUser loginWithUsername:@"janek" password:@"qaz123" toSyncano:syncano completion:^(NSError *error) {
                _error = error;
                _blockFinished = YES;
                loggedUser = [SCUser currentUser];
            }];
            
            [[expectFutureValue(theValue(_blockFinished)) shouldEventually] beYes];
            [[_error shouldEventually] beNil];
            [[loggedUser shouldEventually] beNonNil];
            [[[loggedUser userKey] shouldEventually] beNonNil];
            [[[loggedUser username] shouldEventually] beNonNil];
            
            //Log out
            [loggedUser logout];
            [[[loggedUser userKey] should] beNil];
        });
        

    });
    
    
    
    
    
});

SPEC_END
