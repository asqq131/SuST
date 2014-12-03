//
//  SuSNetwork.h
//  SuS
//
//  Created by HZwu on 14-11-29.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"

@protocol SuSNetworkDelegate <NSObject>

- (void)DPPopulateResponse:(id)data;

@end

@interface SuSNetwork : AFHTTPRequestOperationManager

@property (nonatomic, assign) id<SuSNetworkDelegate> delegate;

+ (instancetype)client;

- (AFHTTPRequestOperation*)request:(NSString*)method
                               url:(NSString*)url
                        parameters:(NSDictionary *)parameters
                       cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                    netWorkUrlType:(NetworkUrlType)networkUrlType
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation*)requestByDPurl:(NSString*)url
                             paramsString:(NSString *)paramsString
                             parameters:(NSDictionary *)parameters
                              cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                                  success:(void (^)(BOOL empty))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
