//
//  SCDataObjectSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "Kiwi.h"
#import "Syncano.h"
#import "Book.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

SPEC_BEGIN(SCDataObjectSpec)

describe(@"SCDataObject", ^{
    
    it(@"should generate class name for API calls", ^{
        [[[Book classNameForAPI] should] equal:@"book"];
    });
    
    it(@"should create properties map", ^{
        NSSet *propsMap = [SCDataObject propertyKeys];
        [[propsMap should] beNonNil];
        [[propsMap should] beKindOfClass:[NSSet class]];
    });
    
    it(@"should register class", ^{
        [Book registerClass];
        SCClassRegisterItem *registerOfClass = [[SCParseManager sharedSCParseManager] registerItemForClass:[Book class]];
        [[registerOfClass shouldNot] beNil];
    });
    
    it(@"should merge keys", ^{
        SCDataObject *dataObjectMock = [SCDataObject new];
        dataObjectMock.objectId = @1222;
        NSDictionary *serializedObject = [MTLJSONAdapter JSONDictionaryFromModel:dataObjectMock error:nil];
        [[serializedObject[@"id"] should] equal:@1222];
    });
    
    context(@"singleton syncano instance", ^{
        
        beforeAll(^{
            [Syncano sharedInstanceWithApiKey:@"API-KEY" instanceName:@"INSTANCE-NAME"];
        });
        
        it(@"should save object", ^{
            
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                return YES;
            } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"Book.json",self.class)
                                                        statusCode:200 headers:@{@"Content-Type":@"application/json"}];
            }];
            
            __block Book *book = [Book new];
            __block NSError *_error;
            __block BOOL _blockFinished;
            [book saveWithCompletionBlock:^(NSError *error) {
                _error = error;
                _blockFinished = YES;
            }];
            
            [[expectFutureValue(theValue(_blockFinished)) shouldEventually] beYes];
            [[_error shouldEventually] beNil];
            [[book.objectId shouldEventually] beNonNil];
        });
        
        it(@"should fetch object", ^{
            
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                return YES;
            } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"Book.json",self.class)
                                                        statusCode:200 headers:@{@"Content-Type":@"application/json"}];
            }];
            
            __block Book *book = [Book new];
            book.objectId = @2;
            __block NSError *_error;
            __block BOOL _blockFinished;
            [book fetchWithCompletion:^(NSError *error) {
                _error = error;
                _blockFinished = YES;
            }];
            
            [[expectFutureValue(theValue(_blockFinished)) shouldEventually] beYes];
            [[_error shouldEventually] beNil];
            [[book.objectId shouldEventually] equal:@2];
            [[book.numOfPages shouldEventually] equal:@123];
            [[book.title shouldEventually] equal:@"googlebook"];
        });
    
    });
});

SPEC_END
