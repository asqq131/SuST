//
//  SuSUser.h
//  SuS
//
//  Created by HZwu on 14-12-1.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuSUser : NSObject

+ (instancetype)user;

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *loaction_city;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;

- (void)setUserInfoByDict:(NSDictionary *)userDict;

@end
