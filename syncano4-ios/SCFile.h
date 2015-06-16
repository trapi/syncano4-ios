//
//  SCFile.h
//  Pods
//
//  Created by Mariusz Wisniewski on 6/16/15.
//
//

#import <Foundation/Foundation.h>
#import "SCConstants.h"

@interface SCFile : NSObject

+ (instancetype)fileWithData:(NSData *)data;
+ (instancetype)fileWithImage:(UIImage *)image type:(SCFileImageType)type;

+ (instancetype)fileWithURL:(NSURL *)url;

- (NSString *)base64represantion;

/**
 *  Fetches NSData object from the link
 *
 *  @param completion comletion block
 */
- (void)fetchDataWithCompletion:(SCFileCompletionBlockWithData)completion;

/**
 *  Fetches UIImage object from the link
 *
 *  @param completion comletion block
 */
- (void)fetchImageDataWithCompletion:(SCFileCompletionBlockWithImage)completion;

@end
