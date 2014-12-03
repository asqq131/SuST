//
//  WTSJSONRequestSerializer.m
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "WTSJSONRequestSerializer.h"

@implementation WTSJSONRequestSerializer

#pragma mark - AFURLRequestSerialization

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    
    NSURLRequest* newRequest = [super requestBySerializingRequest:request
                                                   withParameters:parameters
                                                            error:error];
    return [self populateRequest:newRequest];
}

- (NSURLRequest *)populateRequest:(NSURLRequest*)request
{
    if(request) {
        NSMutableURLRequest* newRequest = [request mutableCopy];
        // TODO 拦截请求，自定义请求，添加鉴权头等
        return newRequest;
    }
    return request;
}

@end
