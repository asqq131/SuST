//
//  NIMutableTableViewModel+WTSNetwork.m
//  EIM
//
//  Created by user on 14-8-25.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "NITableViewModel+WTSNetwork.h"

#import <objc/runtime.h>

#import "NITableViewModel+Private.h"

#import "WTSJSONClient.h"
#import "WTSNetworkOperation.h"

@interface NITableViewModel (_WTSNetwork)
@property (readwrite, nonatomic, strong, setter = wts_setRequestOperation:) AFHTTPRequestOperation *wts_requestOperation;

@end

@implementation NITableViewModel (_WTSNetwork)

- (AFHTTPRequestOperation *)wts_requestOperation
{
    return (AFHTTPRequestOperation *)objc_getAssociatedObject(self, @selector(wts_requestOperation));
}

- (void)wts_setRequestOperation:(AFHTTPRequestOperation *)requestOperation
{
    objc_setAssociatedObject(self, @selector(wts_requestOperation), requestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation NITableViewModel (WTSNetwork)

- (BOOL)isLoading
{
    return ![self.wts_requestOperation isFinished];
}

- (void)request:(NSString*)method
            url:(NSString*)url
     parameters:(NSDictionary *)parameters
    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
        success:(void (^)(BOOL empty))success
        failure:(void (^)(NSError *error))failure
{
    
    __weak __typeof(self)weakSelf = self;
    
    WTSJSONClient* client = [WTSJSONClient client];
    self.wts_requestOperation
    = [client request:method
                  url:url
           parameters:parameters
          cachePolicy:cachePolicy
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  if([weakSelf respondsToSelector:@selector(populateResponse:)]) {
                      [weakSelf performSelector:@selector(populateResponse:)
                                     withObject:responseObject];
                  }
                  BOOL empty = (self.sections.count == 0);
                  success(empty);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failure(error);
              }];
}

- (void)cancelRequest
{
    [self.wts_requestOperation cancel];
}
@end
