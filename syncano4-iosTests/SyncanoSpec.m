//
//  SyncanoSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 26/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "Syncano.h"

SPEC_BEGIN(SyncanoSpec)

describe(@"Syncano", ^{
    beforeAll(^{
        [Syncano setApiKey:@"123" instanceName:@"456"];
    });
    it(@"is setting api key", ^{
        [[[Syncano getApiKey] should] equal:@"123"];
    });
    it(@"is setting instance name", ^{
        [[[Syncano getInstanceName] should] equal:@"456"];
    });
});

SPEC_END
