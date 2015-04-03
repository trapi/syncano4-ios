//
//  SCParseManager.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCParseManager.h"
#import <Mantle.h>
#import <objc/runtime.h>
@interface SCParseManager ()
@property (nonatomic,retain) NSMutableDictionary *registeredSchemas;
@property (nonatomic,retain) NSMutableDictionary *registeredClasses;
@end

@implementation SCParseManager

SINGLETON_IMPL_FOR_CLASS(SCParseManager)

- (id)parsedObjectOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)JSONObject {
    NSError *error;
    id parsedobject = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:JSONObject error:&error];
    
    // Here will be code to other Syncano specific parse actions like references etc.
//    SCSchema *schema = [self schemaForClass:objectClass];
    
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

- (void)registerClass:(__unsafe_unretained Class)classToRegister {
    if ([classToRegister respondsToSelector:@selector(propertyKeys)]) {
        if (!self.registeredClasses) {
            self.registeredClasses = [NSMutableDictionary new];
        }
        NSSet *properties = [classToRegister propertyKeys];
        NSMutableDictionary *registeredProperties = [[NSMutableDictionary alloc] initWithCapacity:properties.count];
        NSString *className;
        if ([classToRegister respondsToSelector:@selector(classNameForAPI)]) {
            className = [classToRegister classNameForAPI];
        } else {
            className = NSStringFromClass(classToRegister);
        }
        for (NSString *property in properties) {
            NSString *typeName = [self typeOfPropertyNamed:property fromClass:classToRegister];
            [registeredProperties setObject:typeName forKey:property];
        }
        [self.registeredClasses setObject:registeredProperties forKey:className];
    }
}

- (NSDictionary *)registerForClass:(__unsafe_unretained Class)registeredClass {
    NSString *className;
    if ([registeredClass respondsToSelector:@selector(classNameForAPI)]) {
        className = [registeredClass classNameForAPI];
    } else {
        className = NSStringFromClass(registeredClass);
    }
    return self.registeredClasses[className];
}

- (NSString *) typeOfPropertyNamed: (NSString *) name fromClass:(__unsafe_unretained Class)class
{
    objc_property_t property = class_getProperty( class, [name UTF8String] );
    if ( property == NULL )
        return ( NULL );
    NSString *typeName = [NSString stringWithUTF8String:property_getTypeString(property)];
    typeName = [typeName stringByReplacingOccurrencesOfString:@"T@\"" withString:@""];
    typeName = [typeName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return typeName;
}

const char * property_getTypeString( objc_property_t property )
{
    const char * attrs = property_getAttributes( property );
    if ( attrs == NULL )
        return ( NULL );
    
    static char buffer[256];
    const char * e = strchr( attrs, ',' );
    if ( e == NULL )
        return ( NULL );
    
    int len = (int)(e - attrs);
    memcpy( buffer, attrs, len );
    buffer[len] = '\0';
    
    return ( buffer );
}
@end
