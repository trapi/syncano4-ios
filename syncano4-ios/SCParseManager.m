//
//  SCParseManager.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCParseManager.h"
#import <Mantle.h>

@interface SCParseManager ()
@property (nonatomic,retain) NSMutableDictionary *registeredSchemas;
@end

@implementation SCParseManager

SINGLETON_IMPL_FOR_CLASS(SCParseManager)

- (id)parsedObjectOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)JSONObject {
    NSError *error;
    id parsedobject = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:JSONObject error:&error];
    
    // Here will be code to other Syncano specific parse actions like references etc.
    SCSchema *schema = [self schemaForClass:objectClass];
    
    return parsedobject;
}

- (NSDictionary *)JSONSerializedDictionaryFromDataObject:(SCDataObject *)dataObject {
    NSDictionary *serialized = [MTLJSONAdapter JSONDictionaryFromModel:dataObject];
    return serialized;
}

- (void)registerSchema:(SCSchema *)schema forAPIClassName:(NSString *)className {
    if (!self.registeredSchemas) {
        self.registeredSchemas = [NSMutableDictionary new];
    }
    [self.registeredSchemas setObject:schema forKey:className];
}

- (SCSchema *)schemaForClass:(__unsafe_unretained Class)class {
    NSString *APIClassName;
    if ([class respondsToSelector:@selector(classNameForAPI)]) {
        APIClassName = [class classNameForAPI];
    }
    if (APIClassName) {
        return self.registeredSchemas[APIClassName];
    }
    return nil;
}
@end
