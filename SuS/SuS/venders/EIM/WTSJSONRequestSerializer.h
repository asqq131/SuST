//
//  WTSJSONRequestSerializer.h
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "AFURLRequestSerialization.h"

@interface WTSJSONRequestSerializer : AFJSONRequestSerializer

// 拦截请求，自定义请求，添加鉴权头等
- (NSURLRequest *)populateRequest:(NSURLRequest*)request;

@end
