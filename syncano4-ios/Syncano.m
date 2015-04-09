//
//  syncano4_ios.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 26/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Syncano.h"
#import "SCAPIClient.h"
#import "SCParseManager.h"
#import "SCAPIClient+Class.h"

@interface Syncano ()
@end

@implementation Syncano

/**
 *  Initiates singleton instance of Syncano Class
 *
 *  @param apiKey       API Key to authorize syncano
 *  @param instanceName name of the Syncano instance
 *
 *  @return Syncano singleton instance
 */
+ (Syncano *)instance {
    static dispatch_once_t pred;
    __strong static Syncano * instance= nil;
    dispatch_once( &pred, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (Syncano *)sharedInstanceWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    Syncano *syncano = [Syncano instance];
    [syncano setApiKey:apiKey instanceName:instanceName];
    syncano.apiClient = [SCAPIClient apiClientForSyncano:syncano];
    return syncano;
}

+ (NSString *)getApiKey {
    return [[Syncano instance] apiKey];
}

+ (NSString *)getInstanceName {
    return [[Syncano instance] instanceName];
}

+ (SCAPIClient *)sharedAPIClient {
    return [[Syncano instance] apiClient];
}

- (instancetype)initWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    self = [super init];
    if (self) {
        self.apiKey = apiKey;
        self.instanceName = instanceName;
        self.apiClient = [SCAPIClient apiClientForSyncano:self];
    }
    return self;
}

+ (Syncano *)newSyncanoWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    Syncano *syncano = [[Syncano alloc] initWithApiKey:apiKey instanceName:instanceName];
    return syncano;
}

+ (Syncano *)testInstance {
    return [Syncano sharedInstanceWithApiKey:@"1429b1898655e3c576d4352cb7ed383946dbc8e4" instanceName:@"mytestinstance"];
}

- (void)setApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    self.apiKey = apiKey;
    self.instanceName = instanceName;
}


@end
