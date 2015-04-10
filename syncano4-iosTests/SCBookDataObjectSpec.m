//
//  SCBookDataObjectSpec.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 02/04/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//


#import "Kiwi.h"
#import "SCMacros.h"
#import "SCConstants.h"
#import "Syncano.h"
#import "SCDataObject.h"
#import "SCQuery.h"
#import "Book.h"
#import "SCParseManager.h"

SPEC_BEGIN(SCBookDataObjectSpec)

describe(@"SCBookDataObject", ^{
    it(@"should get all objects from API", ^{
        __block NSArray *books = nil;
        SCQuery *query = [Book query];
        [query getDataObjectsInBackgroundWithCompletion:^(NSArray *objects, NSError *error) {
            books = objects;
        }];
        [[books shouldNotEventually] beNil];
    });
    it(@"should register class", ^{
        [Book registerClass];
        SCClassRegisterItem *registerOfClass = [[SCParseManager sharedSCParseManager] registerItemForClass:[Book class]];
        [[registerOfClass shouldNot] beNil];
    });
});

SPEC_END
