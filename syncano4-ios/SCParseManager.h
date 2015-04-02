//
//  SCParseManager.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSchema.h"

@interface SCParseManager : NSObject
SINGLETON_FOR_CLASS(SCParseManager);
- (id)parsedObjectOfClass:(__unsafe_unretained Class)objectClass fromJSONObject:(id)JSONObject;
- (NSDictionary *)JSONSerializedDictionaryFromDataObject:(SCDataObject *)dataObject;
- (void)registerSchema:(SCSchema *)schema forAPIClassName:(NSString *)className;
@end
