//
//  WTSJSONResponseSerializer.m
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "WTSJSONResponseSerializer.h"

@implementation WTSJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id responseObject = [super responseObjectForResponse:response
                                                    data:data
                                                   error:error];
    if(responseObject) {
        [self validateResponseObject:responseObject error:error];
    }
    
    return responseObject;
}

- (id)validateResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error
{
    // TODO 拦截响应，校验响应对象，统一解析错误码
    return responseObject;
}

@end
