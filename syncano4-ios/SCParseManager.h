//
//  SCParseManager.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCMacros.h"
#import "SCSchema.h"
#import "SCDataObject.h"

/**
 *  Class contains info about registered class for subclassing
 */
@interface SCClassRegisterItem : NSObject
/**
 *  Name of class using in Syncano
 */
@property (nonatomic,copy) NSString *classNameForAPI;
/**
 *  Local name of subslassed class
 */
@property (nonatomic,copy) NSString *className;
/**
 *  Dictionary stores property names as keys and type names as values
 */
@property (nonatomic,copy) NSDictionary *properties;
@end

/**
 *  Singleton class for SCDataObject parsing
 */
@interface SCParseManager : NSObject

/**
 *  Initializes singleton
 */
SINGLETON_FOR_CLASS(SCParseManager);

/**
 *  Attempts to parse JSON to SCDataObject
 *
 *  @param objectClass Class of object to parse for
 *  @param JSONObject  serialiazed JSON object from API response
 *
 *  @return parsed SCDataObject
 */
- (id)parsedObjectOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)JSONObject;

/**
 *  Converts SCDataObject to JSON representation
 *
 *  @param dataObject SCDataObject to convert
 *
 *  @return JSON representation of SCDataObject
 */
- (NSDictionary *)JSONSerializedDictionaryFromDataObject:(SCDataObject *)dataObject;

/**
 *  Registers class for subclassing
 *
 *  @param classToRegister
 */
- (void)registerClass:(__unsafe_unretained Class)classToRegister;

/**
 *  Returns registered item for provided class
 *
 *  @param registeredClass class to look up register for
 *
 *  @return SCClassRegisterItem for provided class or nil
 */
- (SCClassRegisterItem *)registerItemForClass:(__unsafe_unretained Class)registeredClass;

@end
