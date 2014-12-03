//
//  ZWConstants.h
//  ZW-WeChat
//
//  Created by HZwu on 14-9-12.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef SuSConstants_h
#define SuSConstants_h

#define DPAPIVersion                @"2.0"

#define kDPAPIErrorDomain           @"DPAPIErrorDomain"
#define kDPAPIErrorCodeKey          @"DPAPIErrorCodeKey"

#define kDPAPIDomain				@"http://api.dianping.com/"

/////////////////////////////////////////////////////////////////////////

#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define kIsIOS7Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
//NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1

#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

typedef NS_ENUM(NSInteger, NetworkUrlType) {
    SuSEntrance = 0,
    DPEntrance
};

extern const NSString *loaction_city;

#endif