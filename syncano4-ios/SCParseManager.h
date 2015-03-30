//
//  SCParseManager.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCParseManager : NSObject
SINGLETON_FOR_CLASS(SCParseManager);
- (void)registerClass:(Class)classToRegister;
@end
