//
//  syncano4_ios.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 26/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Syncano : NSObject

@property (nonatomic,copy) NSString *apiKey;
@property (nonatomic,copy) NSString *instanceName;

//Singleton
+ (Syncano *)defaultInstanceWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName;
+ (NSString *)getApiKey;
+ (NSString *)getInstanceName;

//Normal
- (instancetype)initWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName;
+ (Syncano *)newSyncanoWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName;

//Only for tesing
+ (Syncano *)testInstance;
@end
