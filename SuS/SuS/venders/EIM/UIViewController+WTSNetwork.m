//
//  UIViewController+WTSNetwork.m
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "UIViewController+WTSNetwork.h"

#import <objc/runtime.h>

#import "WTSJSONClient.h"

@interface UIViewController (_WTSNetwork)

@property (readwrite, nonatomic, strong, setter = wts_setRequestOperation:) AFHTTPRequestOperation *wts_requestOperation;

@end

@implementation UIViewController (_WTSNetwork)

- (AFHTTPRequestOperation *)wts_requestOperation
{
    return (AFHTTPRequestOperation *)objc_getAssociatedObject(self, @selector(wts_requestOperation));
}

- (void)wts_setRequestOperation:(AFHTTPRequestOperation *)requestOperation
{
    objc_setAssociatedObject(self, @selector(wts_requestOperation), requestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIViewController (WTSNetwork)

- (BOOL)isLoading
{
    return ![self.wts_requestOperation isFinished];
}

- (void)request:(NSString*)method
            url:(NSString*)url
     parameters:(NSDictionary *)parameters
    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure
{
    
    WTSJSONClient* client = [WTSJSONClient client];
    self.wts_requestOperation =
    [client request:method
                url:url
         parameters:parameters
        cachePolicy:cachePolicy
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if(operation == self.wts_requestOperation)
                    success(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                // TODO 检查中止操作
                if(operation == self.wts_requestOperation)
                    failure(error);
            }];
}

- (void)cancelRequest
{
    [self.wts_requestOperation cancel];
}

@end
