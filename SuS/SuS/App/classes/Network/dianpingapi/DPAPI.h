//
//  DPAPI.h
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DPRequest.h"

//@interface DPAPI : NSObject
//
//- (DPRequest*)requestWithURL:(NSString *)url
//					  params:(NSMutableDictionary *)params
//					delegate:(id<DPRequestDelegate>)delegate;
//
//- (DPRequest *)requestWithURL:(NSString *)url
//				 paramsString:(NSString *)paramsString
//					 delegate:(id<DPRequestDelegate>)delegate;
//
//@end


#ifndef apidemo_DPConstants_h
#define apidemo_DPConstants_h

#define DPAPIVersion                @"2.0"

#define kDPAPIErrorDomain           @"DPAPIErrorDomain"
#define kDPAPIErrorCodeKey          @"DPAPIErrorCodeKey"

#define kDPAPIDomain				@"http://api.dianping.com/"
#define kSuSDomain                  @"#"

#define kDPAppKey             @"AppKey"
#define kDPAppSecret          @"AppSecret"

#endif

/********************************************************/


@interface DPAPI : NSObject

+ (instancetype)client;

- (NSString *)serializeURL:(NSString *)baseURL paramsString:(NSString *)paramsString params:(NSDictionary *)params;

@end
