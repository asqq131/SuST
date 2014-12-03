//
//  WTSJSONResponseSerializer.h
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "AFURLResponseSerialization.h"

@interface WTSJSONResponseSerializer : AFJSONResponseSerializer

// 拦截响应，校验响应对象，统一解析错误码等
- (id)validateResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error;

@end
