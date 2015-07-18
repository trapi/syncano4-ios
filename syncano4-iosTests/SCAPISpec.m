//
//  SCAPISpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 27/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "Syncano.h"


SPEC_BEGIN(SCAPISpec)

describe(@"SCAPI", ^{
    
    beforeAll(^{
        //[Syncano testInstance];
    });
    it(@"sending authenticated GET classes request", ^{
        __block NSError *_error;
        SCAPIClient *apiClient = [Syncano sharedAPIClient];
        [apiClient getTaskWithPath:@"classes/" params:nil completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
            _error = error;
        }];
        
        [[expectFutureValue(_error) shouldEventually] beNil];
    });
});

SPEC_END
