//
//  SCDataObjectSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "SCPlease.h"
#import "SCMacros.h"
#import "SCConstants.h"
#import "Syncano.h"
#import "Book.h"


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
        dataObjectMock.objectId = @1222;
        NSDictionary *serializedObject = [MTLJSONAdapter JSONDictionaryFromModel:dataObjectMock];
        [[serializedObject[@"id"] should] equal:@1222];
    });
    it(@"should create object from JSON NSDictionary", ^{
        NSError *error;
        NSDictionary *JSON = @{@"id" : @123,};
        SCDataObject *dataObject = [MTLJSONAdapter modelOfClass:[SCDataObject class] fromJSONDictionary:JSON error:&error];
        [[error should] beNil];
        [[dataObject.objectId should] equal:@123];
    });
    it(@"should fetch objects from API", ^{
        __block NSArray *books;
        [[Book please] giveMeDataObjectsWithCompletion:^(NSArray *objects, NSError *error) {
            books = objects;
        }];
        [[books shouldNotEventually] beNil];
    });
});

SPEC_END
