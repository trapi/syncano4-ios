//
//  SCParseManager.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 30/03/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCParseManager : NSObject
+ (id)parsedObjectOfClass:(Class)objectClass fromJSONObject:(id)JSONObject;
+ (NSDictionary *)JSONSerializedDictionaryFromDataObject:(SCDataObject *)dataObject;
@end
