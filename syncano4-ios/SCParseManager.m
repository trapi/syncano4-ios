//
//  SCParseManager.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCParseManager.h"
#import "ClassHelper.h"

@interface SCParseManager ()
@property (nonatomic,retain)NSMutableDictionary *registeredClasses;
@end

@implementation SCParseManager
SINGLETON_IMPL_FOR_CLASS(SCParseManager)

- (instancetype)init {
    self = [super init];
    if (self) {
        self.registeredClasses = [NSMutableDictionary new];
    }
    return self;
}

- (void)registerClass:(Class)classToRegister {
    NSDictionary *properties = [ClassHelper propertiesForClass:classToRegister];
    [self.registeredClasses setValue:properties forKey:NSStringFromClass(classToRegister)];
}
@end
