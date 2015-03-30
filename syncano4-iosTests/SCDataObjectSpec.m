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
#import "ClassHelper.h"


SPEC_BEGIN(SCDataObjectSpec)

describe(@"SCDataObject", ^{
    beforeAll(^{
    });
    it(@"creating properties map", ^{
        NSDictionary *propsMap = [ClassHelper propertiesForClass:[SCDataObject class]];
        [[propsMap should] beNonNil];
    });
});

SPEC_END
