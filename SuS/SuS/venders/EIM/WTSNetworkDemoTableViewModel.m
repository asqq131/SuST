//
//  WTSNetworkTableViewModel.m
//  EIM
//
//  Created by user on 14-8-25.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "WTSNetworkDemoTableViewModel.h"

#import "NITableViewModel+WTSNetwork.h"

@implementation WTSNetworkDemoTableViewModel


#pragma mark - WTSNetworkOperation

- (void)load:(NSURLRequestCachePolicy)cachePolicy
        more:(BOOL)more
     success:(void (^)(BOOL empty))success
     failure:(void (^)(NSError *error))failure
{
    
    // 构造请求URL
    // TODO 真实样例
    [self request:nil
              url:nil
       parameters:nil
      cachePolicy:NSURLRequestUseProtocolCachePolicy
          success:success
          failure:failure];
}

- (void)populateResponse:(id)data
{
    // TODO 处理响应，生成CELL Object
}

@end
