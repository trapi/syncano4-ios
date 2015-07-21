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
    
     context(@"singleton syncano instance", ^{
        beforeAll(^{
            [Syncano sharedInstanceWithApiKey:@"123" instanceName:@"456"];
        });
        it(@"should set api key", ^{
            [[[Syncano getApiKey] should] equal:@"123"];
        });
        it(@"should set instance name", ^{
            [[[Syncano getInstanceName] should] equal:@"456"];
        });
     });
    
    context(@"custom syncano instance", ^{
        Syncano *syncano = [[Syncano alloc] initWithApiKey:@"API-KEY" instanceName:@"INSTANCE-NAME"];

        it(@"should set api key", ^{
            [[[syncano apiKey] should] equal:@"API-KEY"];
        });
        it(@"should set instance name", ^{
            [[[syncano instanceName] should] equal:@"INSTANCE-NAME"];
        });
    });

});

SPEC_END
