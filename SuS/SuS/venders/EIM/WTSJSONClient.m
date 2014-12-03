//
//  WTSNetworkClient.m
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "WTSJSONClient.h"

#import "WTSConstants.h"
#import "WTSJSONRequestSerializer.h"
#import "WTSJSONResponseSerializer.h"

@implementation WTSJSONClient

+ (instancetype)client
{
    static WTSJSONClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL* baseURL = [NSURL URLWithString:kJSONClientBaseURL];
        _sharedClient = [[self alloc] initWithBaseURL:baseURL];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(self) {
        self.requestSerializer = [WTSJSONRequestSerializer serializer];
        self.responseSerializer = [WTSJSONResponseSerializer serializer];
    }
    return self;
}

- (AFHTTPRequestOperation*)request:(NSString*)method
            url:(NSString*)url
     parameters:(NSDictionary *)parameters
    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request =
    [self.requestSerializer requestWithMethod:method
                                    URLString:[[NSURL URLWithString:url relativeToURL:self.baseURL] absoluteString]
                                   parameters:parameters
                                        error:nil];
    request.cachePolicy = cachePolicy;
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end
