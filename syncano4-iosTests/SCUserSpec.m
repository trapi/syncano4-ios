//
//  SCUserSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 6/07/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "SCUser.h"
#import "SCCannedURLProtocol.h"
#import "KWSpec+WaitFor.h"
#import "Syncano.h"

SPEC_BEGIN(SCUserSpec)

describe(@"SCUser", ^{
    
    Syncano *syncano = [[Syncano alloc] initWithApiKey:@"API-KEY" instanceName:@"INSTANCE-NAME"];

    beforeAll(^{
        [SCCannedURLProtocol registerInAPIClient:syncano.apiClient];
    });
    
    afterAll(^{
        [SCCannedURLProtocol unregisterFromAPIClient:syncano.apiClient];
    });
    
    it(@"should login", ^{
        
        [SCCannedURLProtocol setCannedStatusCode:200];
        NSString *jsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SCUserLogin200"
                                                             ofType:@"json"];
        NSData *responseData = [NSData dataWithContentsOfFile:jsonPath];
        [SCCannedURLProtocol setCannedResponseData:responseData];
                
        __block NSError *terror = [NSError new];
        [SCUser loginWithUsername:@"janek" password:@"qaz123" toSyncano:syncano completion:^(NSError *error) {
            terror = error;
        }];
        
        [[expectFutureValue(terror) shouldEventually] beNil];

    });
    
});

SPEC_END
