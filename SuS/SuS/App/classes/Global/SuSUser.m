//
//  SuSUser.m
//  SuS
//
//  Created by HZwu on 14-12-1.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "SuSUser.h"
#import "Constants.h"

@implementation SuSUser

+ (instancetype)user
{
    static SuSUser *_sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedUser = [[self alloc] init];
    });
    
    return _sharedUser;
}

- (void)setUserInfoByDict:(NSDictionary *)userDict
{
    loaction_city = userDict[@"loaction_city"];
    
//    self.account = userDict[@"account"];
//    self.password = userDict[@"password"];
//    self.loaction_city = userDict[@"loaction_city"];
//    self.latitude = userDict[@"latitude"];
//    self.longitude = userDict[@"longitude"];
}

@end
