//
//  syncano4_ios.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 26/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCMacros.h"
#import "SCConstants.h"
#import "SCPlease.h"
#import "SCDataObject.h"
#import "SCPredicate.h"
#import "SCParseManager.h"
#import "SCParseManager+SCDataObject.h"
#import "SCParseManager+SCUser.h"
#import "SCAPIClient.h"
#import "SCUser.h" 
#import "SCCodeBox.h"
#import "SCWebhook.h"
#import "SCChannel.h"

@class SCAPIClient;
/**
 *  Main Syncano Class
 */
@interface Syncano : NSObject
/**
 *  API Key
 */
@property (nonatomic,copy) NSString *apiKey;
/**
 *  Syncano Instance name
 */
@property (nonatomic,copy) NSString *instanceName;
/**
 *  Session CLient to comunicate with API
 */
@property (nonatomic,retain) SCAPIClient *apiClient;

/**
 *  Initiates Singleton instance of Syncano Class
 *
 *  @param apiKey       API Key to authorize syncano
 *  @param instanceName name of the Syncano instance
 *
 *  @return Syncano singleton instance
 */
+ (Syncano *)sharedInstanceWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName;
/**
 *  Returns API Key from Syncano singleton instance
 *
 *  @return API Key string
 */
+ (NSString *)getApiKey;
/**
 *  Returns API instance name form Syncano singleton instance
 *
 *  @return instance name string
 */
+ (NSString *)getInstanceName;
/**
 *  Returns API client from Syncano singleton instance
 *
 *  @return SCAPIClient object
 */
+ (SCAPIClient *)sharedAPIClient;


/**
 *  Initiates instance of Syncano Class
 *
 *  @param apiKey       API Key to authorize syncano
 *  @param instanceName name of the Syncano instance
 *
 *  @return Syncano singleton instance
 */
- (instancetype)initWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName;

/**
 *  Initiates instance of Syncano Class
 *
 *  @param apiKey       API Key to authorize syncano
 *  @param instanceName name of the Syncano instance
 *
 *  @return Syncano singleton instance
 */
+ (Syncano *)newSyncanoWithApiKey:(NSString *)apiKey instanceName:(NSString *)instanceName;

/**
 *  Initiates Test instance of Syncano Class
 *
 *  @param apiKey       API Key to authorize syncano
 *  @param instanceName name of the Syncano instance
 *
 *  @return Syncano singleton instance
 */
+ (Syncano *)testInstance;

@end
