//
//  SCCannedURLProtocol.m
//  syncano4-ios
//
//  Created by Jan Lipmann on 14/07/15.
//  Copyright (c) 2015 Syncano. All rights reserved.
//

#import "SCCannedURLProtocol.h"

static NSData *SCCannedResponseData = nil;
static NSDictionary *SCCannedHeaders = nil;
static NSInteger SCCannedStatusCode = 200;
static NSError *SCCannedError = nil;


@implementation SCCannedURLProtocol
+ (void)registerInAPIClient:(SCAPIClient *)apiClient {
    [NSURLProtocol registerClass:[self class]];
    
    NSMutableArray *protocolsArray = [NSMutableArray arrayWithArray:apiClient.session.configuration.protocolClasses];
    [protocolsArray insertObject:[self class] atIndex:0];
    apiClient.session.configuration.protocolClasses = [protocolsArray copy];
}

+ (void)unregisterFromAPIClient:(SCAPIClient *)apiClient {
    [NSURLProtocol unregisterClass:[self class]];
    
    NSMutableArray *protocolsArray = [NSMutableArray arrayWithArray:apiClient.session.configuration.protocolClasses];
    [protocolsArray removeObject:[self class]];
    apiClient.session.configuration.protocolClasses = [protocolsArray copy];
    
    [self setCannedHeaders:nil];
    [self setCannedResponseData:nil];
    [self setCannedError:nil];
}

+ (void)setCannedError:(NSError *)error {
    SCCannedError = error;
}

+ (void)setCannedHeaders:(NSDictionary *)headers {
    SCCannedHeaders = headers;
}

+ (void)setCannedResponseData:(NSData *)data {
    SCCannedResponseData = data;
}

+ (void)setCannedStatusCode:(NSInteger)statusCode {
    SCCannedStatusCode = statusCode;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [[[request URL] scheme] isEqualToString:@"https"]
    && ([[request HTTPMethod] isEqualToString:@"GET"] || [[request HTTPMethod] isEqualToString:@"POST"]);
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSURLRequest *request = [self request];
    id client = [self client];
    
    if(SCCannedError) {
        [client URLProtocol:self didFailWithError:SCCannedError];
    }
    else {
        [self mockRequest:request data:nil];
    }
}


-(void) mockRequest:(NSURLRequest*)request data:(NSData*)data {
    id client = [self client];
    NSDictionary *headers = @{@"Access-Control-Allow-Origin" : @"*", @"Access-Control-Allow-Headers" : @"Content-Type" , @"Content-Type" : @"application/json"};
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:SCCannedStatusCode HTTPVersion:@"1.1" headerFields:headers];
    [client URLProtocol:self didReceiveResponse:response
     cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [client URLProtocol:self didLoadData:data];
    [client URLProtocolDidFinishLoading:self];
}

+ (void)setTimeoutError {
    [self setCannedError:[NSError errorWithDomain:NSURLErrorDomain
                                             code:kCFURLErrorTimedOut
                                         userInfo:nil]];
}
@end
