//
//  SCParseManager+SCDataObject.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 07/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCParseManager+SCDataObject.h"
#import "SCDataObject.h"
#import <objc/runtime.h>

@implementation SCClassRegisterItem
@end

@implementation SCParseManager (SCDataObject)

- (void)setRegisteredClasses:(NSMutableArray *)registeredClasses {
    objc_setAssociatedObject(self, @selector(registeredClasses), registeredClasses, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)registeredClasses {
    return objc_getAssociatedObject(self, @selector(registeredClasses));
}

- (id)parsedObjectOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)JSONObject {
    NSError *error;
    id parsedobject = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:JSONObject error:&error];
    
    NSDictionary *relations = [self relationsForClass:objectClass];
    for (NSString *relationKeyProperty in relations.allKeys) {
        SCClassRegisterItem *relationRegisteredItem = relations[relationKeyProperty];
        Class relatedClass = NSClassFromString(relationRegisteredItem.className);
        id relatedObject = [[relatedClass alloc] init];
        NSNumber *relatedObjectId = JSONObject[relationKeyProperty][@"value"];
        if (relatedObjectId) {
            [relatedObject setValue:relatedObjectId forKey:@"objectId"];
            SCValidateAndSetValue(parsedobject, relationKeyProperty, relatedObject, YES, nil);
        }
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

- (void)updateObject:(SCDataObject *)object withDataFromJSONObject:(id)responseObject {
    /**
     *  Here we have to figure out which attributes needs to be updated after saving object to API i think that only these from main SCDataObject class
     */
    object.objectId = responseObject[@"id"];
    object.created_at = responseObject[@"created_at"];
    object.links = responseObject[@"links"];
    object.updated_at = responseObject[@"updated_at"];
    object.revision = responseObject[@"revision"];
    
    //id newParsedObject = [self parsedObjectOfClass:[object class] fromJSONObject:responseObject];
    //[object mergeValuesForKeysFromModel:newParsedObject];
}

- (NSDictionary *)JSONSerializedDictionaryFromDataObject:(SCDataObject *)dataObject error:(NSError *__autoreleasing *)error {
    NSDictionary *serialized = [MTLJSONAdapter JSONDictionaryFromModel:dataObject];
    /**
     *  Temporary remove non saved relations
     */
    NSDictionary *relations = [self relationsForClass:[dataObject class]];
    if (relations.count > 0) {
        NSMutableDictionary *mutableSerialized = serialized.mutableCopy;
        for (NSString *relationProperty in relations.allKeys) {
            id relatedObject = [dataObject valueForKey:relationProperty];
            NSNumber *objectId = [relatedObject valueForKey:@"objectId"];
            if (objectId) {
                [mutableSerialized setObject:objectId forKey:relationProperty];
            } else {
                if (error != NULL) {
                    NSDictionary *userInfo = @{
                                               NSLocalizedDescriptionKey: NSLocalizedString(@"Unsaved relation", @""),
                                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"You can not add reference for unsaved object",@""),
                                               };
                    *error = [NSError errorWithDomain:@"SCParseManagerErrorDomain" code:1 userInfo:userInfo];
                }
                [mutableSerialized removeObjectForKey:relationProperty];
            }
        }
        serialized = mutableSerialized;
    }
    return serialized;
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

@end
