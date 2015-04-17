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
#import "SCDataObject.h"

@implementation SCClassRegisterItem
@end

@interface SCParseManager ()
/**
 *  Array of SCClassRegisterItems
 */
@property (nonatomic,retain) NSMutableArray *registeredClasses;
@end

@implementation SCParseManager

SINGLETON_IMPL_FOR_CLASS(SCParseManager)

- (id)parsedObjectOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)JSONObject {
    
    NSError *error;
    id parsedobject = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:JSONObject error:&error];
    
    NSDictionary *relations = [self relationsForClass:objectClass];
    /**
     *  TODO: Here we are waiting relation base od repsonse object info  {"type":"reference","class":"test","value":"12334"}
     */
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    for (NSString *relationKeyProperty in relations.allKeys) {
        SCClassRegisterItem *relationRegisteredItem = relations[relationKeyProperty];
        Class relatedClass = NSClassFromString(relationRegisteredItem.className);
        id relatedObject = [[relatedClass alloc] init];
        [relatedObject setValue:JSONObject[relationKeyProperty] forKey:@"objectId"];
        SCValidateAndSetValue(parsedobject, relationKeyProperty, relatedObject, YES, nil);
    }
    return parsedobject;
}

- (NSArray *)parsedObjectsOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)responseObject {
    
    NSArray *responseObjects = responseObject;
    NSMutableArray *parsedObjects = [[NSMutableArray alloc] initWithCapacity:responseObjects.count];
    for (NSDictionary *object in responseObjects) {
        [parsedObjects addObject:[self parsedObjectOfClass:objectClass fromJSONObject:object]];
    }
    return [NSArray arrayWithArray:parsedObjects];
}

- (NSDictionary *)JSONSerializedDictionaryFromDataObject:(SCDataObject *)dataObject {
    NSDictionary *serialized = [MTLJSONAdapter JSONDictionaryFromModel:dataObject];
    return serialized;
}

/**
 *  Returns relations for provided class
 *
 *  @param class provided class
 *
 *  @return NSDictionary with property name as 'key' and SCClassRegisterItem as 'value' or empty NSDictionary if there are no relations
 */
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

/**
 *  Returns type of property from provided class
 *
 *  @param name  property name
 *  @param class
 *
 *  @return property type string or NULL
 */
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

/**
 *  Converts objc_property_t to const char *
 *
 *  @param property objc_property_t to convert
 *
 *  @return converted const char *
 */
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

/**
 *  Returns register for provided Class
 *
 *  @param registeredClass class too look up for
 *
 *  @return SCClassRegisterItem or nil
 */
- (SCClassRegisterItem *)registerItemForClass:(__unsafe_unretained Class)registeredClass {
    return [self registerItemForClassName:NSStringFromClass(registeredClass)];
}

/**
 *  Returns register for provided Class name
 *
 *  @param className class name too look up for
 *
 *  @return SCClassRegisterItem or nil
 */
- (SCClassRegisterItem *)registerItemForClassName:(NSString *)className {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"className == %@",className];
    SCClassRegisterItem *item = [[self.registeredClasses filteredArrayUsingPredicate:predicate] lastObject];
    return item;
}

/**
 *  Validates a value for an object and sets it if necessary. Method copied from Mantle
 *
 *  @param obj         The object for which the value is being validated. This value must not be nil.
 *  @param key         The name of one of `obj`s properties. This value must not be nil.
 *  @param value       The new value for the property identified by `key`.
 *  @param forceUpdate If set to `YES`, the value is being updated even if validating it did not change it.
 *  @param error       If not NULL, this may be set to any error that occurs during validation
 *
 *  @return YES if `value` could be validated and set, or NO if an error occurred.
 */

static BOOL SCValidateAndSetValue(id obj, NSString *key, id value, BOOL forceUpdate, NSError **error) {
    // Mark this as being autoreleased, because validateValue may return
    // a new object to be stored in this variable (and we don't want ARC to
    // double-free or leak the old or new values).
    __autoreleasing id validatedValue = value;
    
    @try {
        if (![obj validateValue:&validatedValue forKey:key error:error]) return NO;
        
        if (forceUpdate || value != validatedValue) {
            [obj setValue:validatedValue forKey:key];
        }
        
        return YES;
    } @catch (NSException *ex) {
        NSLog(@"*** Caught exception setting key \"%@\" : %@", key, ex);
        
        // Fail fast in Debug builds.
#if DEBUG
        @throw ex;
#else
        if (error != NULL) {
            *error = [NSError mtl_modelErrorWithException:ex];
        }
        
        return NO;
#endif
    }
}
@end
