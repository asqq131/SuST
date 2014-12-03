//
//  UIViewController+WTSNetwork.h
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WTSNetwork)

// 网络加载中
- (BOOL)isLoading;

// 发送网络请求
- (void)request:(NSString*)method
            url:(NSString*)url
     parameters:(NSDictionary *)parameters
    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;

// 中断网络请求
- (void)cancelRequest;

@end
