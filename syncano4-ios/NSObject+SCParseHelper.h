//
//  NSObject+SCParseHelper.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 12/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SCParseHelper)
- (NSString *)ph_stringOrEmpty;
- (NSNumber *)ph_numberOrNil;
- (NSArray *)ph_arrayOrNil;
- (NSDictionary *)ph_dictionaryOrNil;
@end
