//
//  DPAPI.m
//  apidemo
//
//  Created by ZhouHui on 13-1-28.
//  Copyright (c) 2013年 Dianping. All rights reserved.
//

#import "DPAPI.h"

#import <CommonCrypto/CommonDigest.h>

//@interface DPAPI (Private)
//
//@end
//
//
//@implementation DPAPI {
//	NSMutableSet *requests;
//}
//
//- (id)init {
//	self = [super init];
//    if (self) {
//        requests = [[NSMutableSet alloc] init];
//    }
//    return self;
//}
//
//- (DPRequest*)requestWithURL:(NSString *)url
//					  params:(NSMutableDictionary *)params
//					delegate:(id<DPRequestDelegate>)delegate {
//	if (params == nil) {
//        params = [NSMutableDictionary dictionary];
//    }
//    
//	NSString *fullURL = [kDPAPIDomain stringByAppendingString:url];
//	
//	DPRequest *_request = [DPRequest requestWithURL:fullURL
//											 params:params
//										   delegate:delegate];
//	_request.dpapi = self;
//	[requests addObject:_request];
//	[_request connect];
//	return _request;
//}
//
//- (DPRequest *)requestWithURL:(NSString *)url
//				 paramsString:(NSString *)paramsString
//					 delegate:(id<DPRequestDelegate>)delegate {
//	return [self requestWithURL:[NSString stringWithFormat:@"%@?%@", url, paramsString] params:nil delegate:delegate];
//}
//
//- (void)requestDidFinish:(DPRequest *)request
//{
//    [requests removeObject:request];
//    request.dpapi = nil;
//}
//
//- (void)dealloc
//{
//    for (DPRequest* _request in requests)
//    {
//        _request.dpapi = nil;
//    }
//}
//
//@end


/********************************************************/

@implementation DPAPI

+ (instancetype)client
{
    static DPAPI *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}

#pragma mark - Private Methods

- (void)appendUTF8Body:(NSMutableData *)body dataString:(NSString *)dataString {
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
		
		if ([elements count] <= 1) {
			return nil;
		}
		
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

- (NSString *)serializeURL:(NSString *)baseURL paramsString:(NSString *)paramsString params:(NSDictionary *)params
{
    NSString *urlString = [NSString stringWithFormat:@"%@?%@", baseURL, paramsString];
    NSString *fullURL = [kDPAPIDomain stringByAppendingString:urlString];
    
	NSURL* parsedURL = [NSURL URLWithString:[fullURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[self parseQueryString:[parsedURL query]]];
	if (params) {
		[paramsDic setValuesForKeysWithDictionary:params];
	}
	
	NSMutableString *signString = [NSMutableString stringWithString:kDPAppKey];
	NSMutableString *appkeyString = [NSMutableString stringWithFormat:@"appkey=%@", kDPAppKey];
	NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
	for (NSString *key in sortedKeys) {
		[signString appendFormat:@"%@%@", key, [paramsDic objectForKey:key]];
		[appkeyString appendFormat:@"&%@=%@", key, [paramsDic objectForKey:key]];
	}
	[signString appendString: kDPAppSecret];
	unsigned char digest[CC_SHA1_DIGEST_LENGTH];
	NSData *stringBytes = [signString dataUsingEncoding: NSUTF8StringEncoding];
	if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
		/* SHA-1 hash has been calculated and stored in 'digest'. */
		NSMutableString *digestString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
		for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
			unsigned char aChar = digest[i];
			[digestString appendFormat:@"%02X", aChar];
		}
		[appkeyString appendFormat:@"&sign=%@", [digestString uppercaseString]];
		return [NSString stringWithFormat:@"%@://%@%@?%@", [parsedURL scheme], [parsedURL host], [parsedURL path], [appkeyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	} else {
		return nil;
	}
}

/*
- (AFHTTPRequestOperation *)request:(NSString*)method
                               url:(NSString*)url
                        parameters:(NSDictionary *)parameters
                       cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                     netWorkUrlType:(NetworkUrlType)networkUrlType
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *fullURL;
    NSString* urlString;
    
    if (networkUrlType == DPEntrance) {
        fullURL = [kDPAPIDomain stringByAppendingString:url];
        urlString = [[self class] serializeURL:fullURL params:parameters];
        
    } else if (networkUrlType == SuSEntrance) {
        // TODO
    }
    
    NSMutableURLRequest *request =
    [self.requestSerializer requestWithMethod:method
                                    URLString:urlString
                                   parameters:parameters
                                        error:nil];
    request.cachePolicy = cachePolicy;
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)request:(NSString *)method
                                url:(NSString *)url
                       paramsString:(NSString *)paramsString
                        cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                     netWorkUrlType:(NetworkUrlType)networkUrlType
                            success:(void (^)(AFHTTPRequestOperation *, id))success
                            failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    return [self request:method url:[NSString stringWithFormat:@"%@?%@", url, paramsString] parameters:nil cachePolicy:cachePolicy netWorkUrlType:networkUrlType success:success failure:failure];
}

- (AFHTTPRequestOperation *)requestByDPurl:(NSString *)url
                              paramsString:(NSString *)paramsString
                               cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                                   success:(void (^)(AFHTTPRequestOperation *, id))success
                                   failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    return [self request:@"GET" url:[NSString stringWithFormat:@"%@?%@", url, paramsString] parameters:nil cachePolicy:cachePolicy netWorkUrlType:DPEntrance success:success failure:failure];
}
*/

@end