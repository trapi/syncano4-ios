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
#import "SCDataObjectAPISubclass.h"

@implementation SCClassRegisterItem

@end

@interface SCParseManager ()
@property (nonatomic,retain) NSMutableDictionary *registeredSchemas;
@property (nonatomic,retain) NSMutableArray *registeredClasses;
@end

@implementation SCParseManager

SINGLETON_IMPL_FOR_CLASS(SCParseManager)

- (id)parsedObjectOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)JSONObject {
    NSError *error;
    id parsedobject = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:JSONObject error:&error];
    
    NSDictionary *relations = [self relationsForClass:objectClass];
    
    for (NSString *relationKeyProperty in relations.allKeys) {
        SCClassRegisterItem *relationRegisteredItem = relations[relationKeyProperty];
        Class relatedClass = NSClassFromString(relationRegisteredItem.className);
        id relatedObject = [[relatedClass alloc] init];
        [relatedObject setValue:JSONObject[relationKeyProperty] forKey:@"objectId"];
        [parsedobject setValue:relatedObject forKey:relationKeyProperty];
    }
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

- (NSDictionary *)relationsForClass:(__unsafe_unretained Class)class {
    SCClassRegisterItem *registerForClass = [self registerItemForClass:class];
    NSMutableDictionary *relations = [NSMutableDictionary new];
    for (NSString *propertyName in registerForClass.properties.allKeys) {
        NSString *propertyType = registerForClass.properties[propertyName];
        SCClassRegisterItem *item = [self registerItemForClassName:propertyType];
        if (item) {
            [relations setObject:item forKey:propertyName];
        }
    }
    return relations;
}

- (void)registerClass:(__unsafe_unretained Class)classToRegister {
    NSAssert([classToRegister conformsToProtocol:@protocol(SCDataObjectAPISubclass)], @"Class must conforms to SCDataObjectAPISubclass protocol");
    if ([classToRegister respondsToSelector:@selector(propertyKeys)]) {
        if (!self.registeredClasses) {
            self.registeredClasses = [NSMutableArray new];
        }
        NSSet *properties = [classToRegister propertyKeys];
        NSMutableDictionary *registeredProperties = [[NSMutableDictionary alloc] initWithCapacity:properties.count];
        NSString *classNameForAPI;
        if ([classToRegister respondsToSelector:@selector(classNameForAPI)]) {
            classNameForAPI = [classToRegister classNameForAPI];
        }
        for (NSString *property in properties) {
            NSString *typeName = [self typeOfPropertyNamed:property fromClass:classToRegister];
            [registeredProperties setObject:typeName forKey:property];
        }
        SCClassRegisterItem *registerItem = [SCClassRegisterItem new];
        registerItem.classNameForAPI = classNameForAPI;
        registerItem.className = NSStringFromClass(classToRegister);
        registerItem.properties = registeredProperties;
        [self.registeredClasses addObject:registerItem];
    }
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

- (SCClassRegisterItem *)registerItemForClass:(__unsafe_unretained Class)registeredClass {
    return [self registerItemForClassName:NSStringFromClass(registeredClass)];
}

- (SCClassRegisterItem *)registerItemForClassName:(NSString *)className {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"className == %@",className];
    SCClassRegisterItem *item = [[self.registeredClasses filteredArrayUsingPredicate:predicate] lastObject];
    return item;
}
@end
