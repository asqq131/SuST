//
//  WTSNetworkTableViewModelProtocol.h
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTSNetworkOperation <NSObject>

@optional

// 加载网络数据
- (void)load:(NSURLRequestCachePolicy)cachePolicy
        more:(BOOL)more
     success:(void (^)(BOOL empty))success
     failure:(void (^)(NSError *error))failure;

// 处理网络数据
- (void)populateResponse:(id)data;

@end
