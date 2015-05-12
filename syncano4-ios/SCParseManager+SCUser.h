//
//  SCParseManager+SCUser.h
//  syncano4-ios
//
//  Created by Jan Lipmann on 07/05/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCParseManager.h"
@class SCUser;

@interface SCParseManager (SCUser)
- (SCUser *)parsedUserObjectFromJSONObject:(id)JSONObject;
@end
