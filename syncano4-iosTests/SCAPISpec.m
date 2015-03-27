//
//  SCAPISpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "SCMacros.h"
#import "SCConstants.h"
#import "Syncano.h"
#import "SCAPIClient.h"


SPEC_BEGIN(SCAPISpec)

describe(@"SCAPI", ^{
    beforeAll(^{
        [Syncano setApiKey:@"1429b1898655e3c576d4352cb7ed383946dbc8e4" instanceName:@"mytestinstance"];
    });
    it(@"sending authenticated GET classes request", ^{
        __block NSError *_error = [NSError new];
        [[SCAPIClient sharedSCAPIClient] getTaskWithPath:@"classes/" params:nil completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
            _error = error;
        }];
        
        [[expectFutureValue(_error) shouldEventually] beNil];
    });
});

SPEC_END
