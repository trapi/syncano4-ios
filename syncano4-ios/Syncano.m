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

+ (Syncano *)defaultInstanceWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    Syncano *syncano = [Syncano instance];
    [syncano setApiKey:apiKey instanceName:instanceName];
    return syncano;
}

+ (NSString *)getApiKey {
    return [[Syncano instance] apiKey];
}

+ (NSString *)getInstanceName {
    return [[Syncano instance] instanceName];
}

- (instancetype)initWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    self = [super init];
    if (self) {
        self.apiKey = apiKey;
        self.instanceName = instanceName;
    }
    return self;
}

+ (Syncano *)newSyncanoWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    Syncano *syncano = [[Syncano alloc] initWithApiKey:apiKey instanceName:instanceName];
    return syncano;
}

+ (Syncano *)testInstance {
    return [Syncano defaultInstanceWithApiKey:@"1429b1898655e3c576d4352cb7ed383946dbc8e4" instanceName:@"mytestinstance"];
}

- (void)setApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    _apiKey = apiKey;
    _instanceName = instanceName;
}

@end
