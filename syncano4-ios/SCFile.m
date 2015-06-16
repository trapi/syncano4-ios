//
//  SCFile.m
//  Pods
//
//  Created by Mariusz Wisniewski on 6/16/15.
//
//

#import "SCFile.h"
#import "SCAPIClient.h"

@interface SCFile()

@property (strong) NSData *data;
@property (strong) NSURL *fileLink;

+ (NSData *)dataFromImage:(UIImage *)image as:(SCFileImageType)type;
+ (NSData *)dataFromImageAsPNG:(UIImage *)image;
+ (NSData *)dataFromImageAsJPEG:(UIImage *)image;

@end

@implementation SCFile

#pragma mark - Private

- (id)init {
    return [self initWithData:nil];
}

- (id)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

- (id)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.fileLink = url;
    }
    return self;
}

+ (NSData *)dataFromImage:(UIImage *)image as:(SCFileImageType)type {
    NSData *data = nil;
    switch (type) {
        case SCFileImageTypeJPEG:
            data = [self dataFromImageAsJPEG:image];
            break;
        case SCFileImageTypePNG:
            data = [self dataFromImageAsPNG:image];
            break;
        default:
            data = nil;
            break;
    }
    return data;
}

+ (NSData *)dataFromImageAsPNG:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    return data;
}

+ (NSData *)dataFromImageAsJPEG:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    return data;
}

#pragma mark - Public

+ (instancetype)fileWithData:(NSData *)data {
    SCFile *file = [[self alloc] initWithData:data];
    return file;
}

+ (instancetype)fileWithImage:(UIImage *)image type:(SCFileImageType)type {
    NSData *data = [self dataFromImage:image as:type];
    return [self fileWithData:data];
}

+ (instancetype)fileWithURL:(NSURL *)url {
    SCFile *file = [[self alloc] initWithURL:url];
    return file;
}

- (NSString *)base64represantion {
    NSString *base64 = [self.data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn|NSDataBase64Encoding64CharacterLineLength];
    return base64;
}

- (void)fetchDataWithCompletion:(SCFileCompletionBlockWithData)completion {
    NSString *path = [self.fileLink absoluteString];
    SCAPIClient *apiClient = [[SCAPIClient alloc] init];
    apiClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    [apiClient GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            NSData *data = responseObject;
            completion(data, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil,error);
        }
    }];
}

- (void)fetchImageDataWithCompletion:(SCFileCompletionBlockWithImage)completion {
    [self fetchDataWithCompletion:^(NSData *data, NSError *error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = nil;
            if (data) {
                image = [UIImage imageWithData:data];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(image, error);
                }
            });
        });
    }];
}

@end
