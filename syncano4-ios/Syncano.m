//
//  syncano4_ios.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 26/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Syncano.h"

static NSString * _apiKey;
static NSString * _instanceName;

@implementation Syncano

+ (void)setApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName {
    _apiKey = apiKey;
    _instanceName = instanceName;
}

+ (NSString *)getApiKey {
    return _apiKey;
}

+ (NSString *)getInstancdName {
    return _instanceName;
}

@end
