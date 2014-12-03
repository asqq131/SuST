//
//  SuSSqlite.h
//  SuS
//
//  Created by HZwu on 14-12-1.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuSSqlite : NSObject

+ (instancetype)db;

- (BOOL)sqlHasLoactionCity;

- (NSDictionary *)ToGetUserBySql;
- (BOOL)insertUserInfoByLoaction:(NSString* const)loaction;   // 插入定位城市
- (void)updateUserInfoByLoaction:(NSString* const)loaction;   // 更新数据库定位城市

@end
