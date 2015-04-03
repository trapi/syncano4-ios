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

@interface SCParseManager : NSObject
SINGLETON_FOR_CLASS(SCParseManager);
- (id)parsedObjectOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)JSONObject;
- (NSDictionary *)JSONSerializedDictionaryFromDataObject:(SCDataObject *)dataObject;

- (void)registerClass:(__unsafe_unretained Class)classToRegister;
- (NSDictionary *)registerForClass:(__unsafe_unretained Class)registeredClass;

//Needed only when parsing the relations will depend on schema (NOT NEEDED NOW)
- (void)registerSchema:(SCSchema *)schema forAPIClassName:(NSString *)className;
- (SCSchema *)schemaForClass:(__unsafe_unretained Class)class;
@end
