//
//  SuSNetwork.m
//  SuS
//
//  Created by HZwu on 14-11-29.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "SuSNetwork.h"

#import "DPAPI.h"

@implementation SuSNetwork

+ (instancetype)client
{
    static SuSNetwork *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

#pragma 通用网络请求接口
- (AFHTTPRequestOperation *)request:(NSString*)method
                                url:(NSString*)url
                         parameters:(NSDictionary *)parameters
                        cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                     netWorkUrlType:(NetworkUrlType)networkUrlType
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request =
    [self.requestSerializer requestWithMethod:method
                                    URLString:url
                                   parameters:parameters
                                        error:nil];
    request.cachePolicy = cachePolicy;
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

#pragma DP网络请求接口
- (AFHTTPRequestOperation *)requestByDPurl:(NSString *)url
                              paramsString:(NSString *)paramsString
                              parameters:(NSDictionary *)parameters
                               cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                                   success:(void (^)(BOOL empty))success
                                   failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    __weak __typeof(self)weakSelf = self;
    
    // 使用点评的算法生成签名
    NSString* fullUrl = [[DPAPI client] serializeURL:url paramsString:paramsString params:parameters];
    
//    [self request:@"GET" url:fullUrl parameters:parameters cachePolicy:cachePolicy netWorkUrlType:DPEntrance success:success failure:failure];
    
    return [self request:@"GET" url:fullUrl parameters:parameters cachePolicy:cachePolicy netWorkUrlType:DPEntrance success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([weakSelf.delegate respondsToSelector:@selector(DPPopulateResponse:)]) {
            [weakSelf.delegate DPPopulateResponse:responseObject];
        }
        
        NSDictionary *dict = responseObject;
        BOOL empty = (dict.count == 0);
        success(empty);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

@end
