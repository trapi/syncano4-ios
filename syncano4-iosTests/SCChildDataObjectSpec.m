//
//  SCChildDataObjectSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 01/04/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "SCMacros.h"
#import "SCConstants.h"
#import "Syncano.h"
#import "SCChildDataObject.h"


SPEC_BEGIN(SCChildDataObjectSpec)

describe(@"SCChildDataObject", ^{
    beforeAll(^{
    });
    it(@"should create properties map", ^{
        NSSet *propsMap = [SCChildDataObject propertyKeys];
        [[propsMap should] beNonNil];
    });
    it(@"should merge keys", ^{
        SCChildDataObject *dataObjectMock = [SCChildDataObject new];
        dataObjectMock.classDescription = @"classDescriptionString";
        dataObjectMock.childName = @"child name";
        NSDictionary *serializedObject = [MTLJSONAdapter JSONDictionaryFromModel:dataObjectMock];
        [[serializedObject[@"description"] should] equal:@"classDescriptionString"];
    });
});

SPEC_END
