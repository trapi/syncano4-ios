//
//  syncano4_ios.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 26/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Syncano.h"

@implementation Syncano

+ (Syncano *)instance {
    static dispatch_once_t pred;
    __strong static Syncano * instance= nil;
    dispatch_once( &pred, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)setApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    _apiKey = apiKey;
    _instanceName = instanceName;
}

+ (Syncano *)testInstance {
    Syncano *syncano = [Syncano instance];
    [syncano setApiKey:@"1429b1898655e3c576d4352cb7ed383946dbc8e4" instanceName:@"mytestinstance"];
    return syncano;
}

@end
