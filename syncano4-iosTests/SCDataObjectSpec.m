//
//  SCDataObjectSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "SCMacros.h"
#import "SCConstants.h"
#import "Syncano.h"
#import "SCDataObject.h"


SPEC_BEGIN(SCDataObjectSpec)

describe(@"SCDataObject", ^{
    beforeAll(^{
    });
    it(@"should create properties map", ^{
        NSSet *propsMap = [SCDataObject propertyKeys];
        [[propsMap should] beNonNil];
    });
    it(@"should merge keys", ^{
        SCDataObject *dataObjectMock = [SCDataObject new];
        dataObjectMock.classDescription = @"classDescriptionString";
        NSDictionary *serializedObject = [MTLJSONAdapter JSONDictionaryFromModel:dataObjectMock];
        [[serializedObject[@"description"] should] equal:@"classDescriptionString"];
    });
    it(@"should create object from JSON NSDictionary", ^{
        NSError *error;
        NSDictionary *JSON = @{@"id" : @123,
                       @"description" : @"class description" };
        SCDataObject *dataObject = [MTLJSONAdapter modelOfClass:[SCDataObject class] fromJSONDictionary:JSON error:&error];
        [[error should] beNil];
        [[dataObject.objectId should] equal:@123];
        [[dataObject.classDescription should] equal:@"class description"];
    });
});

SPEC_END
