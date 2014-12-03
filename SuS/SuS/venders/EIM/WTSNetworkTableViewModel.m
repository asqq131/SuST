//
//  WTSNetworkTableViewModel.m
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "WTSNetworkTableViewModel.h"

#import "NITableViewModel+WTSNetwork.h"

@implementation WTSNetworkTableViewModel

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
