//
//  WTSNetworkClient.h
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"


@interface WTSJSONClient : AFHTTPRequestOperationManager

+ (instancetype)client;

- (AFHTTPRequestOperation*)request:(NSString*)method
            url:(NSString*)url
     parameters:(NSDictionary *)parameters
    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
