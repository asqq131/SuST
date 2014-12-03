//
//  SuSSqlite.m
//  SuS
//
//  Created by HZwu on 14-12-1.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#define DBNAME    @"user.sqlite"

#import "SuSSqlite.h"
#import "sql_define.h"
#import <sqlite3.h>
#import "Constants.h"

@interface SuSSqlite ()
{
    sqlite3 *db;
}

@end

@implementation SuSSqlite

+ (instancetype)db
{
    static SuSSqlite *_sharedDB = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDB = [[self alloc] init];
    });
    
    return _sharedDB;
}

- (id)init
{
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
        
        __weak typeof(self)weadSelf = self;
        [self openSqlByPath:database_path result:^(BOOL succeed) {
            if (succeed) {
                [weadSelf createSql];
            }
        }];
    }
    
    return self;
}

- (void)openSqlByPath:(NSString *)path result:(void (^)(BOOL succeed))result
{
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        result(false);
        
        DLog(@"数据库打开失败");
    } else {
        result(true);
    }
}

- (void)createSql
{
    [self execSql:kUserInfo];
}

- (BOOL)execSql:(NSString *)sql
{
    BOOL result = true;
    char *err;
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        result = false;
        
        DLog(@"数据库操作数据失败! error by: %@", [[NSString alloc] initWithUTF8String:err]);
    }
    
    return result;
}

- (NSDictionary *)ToGetUserBySql
{
    sqlite3_stmt * statement;
    NSString *sqlQuery = @"SELECT * FROM userInfo";
    
    NSDictionary *userInfo;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *item = (char*)sqlite3_column_text(statement, 0);
            NSString *str = [[NSString alloc]initWithUTF8String:item];
            
            char *item1 = (char*)sqlite3_column_text(statement, 1);
            NSString *str1 = [[NSString alloc]initWithUTF8String:item1];
            
            char *item2 = (char*)sqlite3_column_text(statement, 2);
            NSString *str2 = [[NSString alloc]initWithUTF8String:item2];
            
            char *item3 = (char*)sqlite3_column_text(statement, 3);
            NSString *str3 = [[NSString alloc]initWithUTF8String:item3];
            
            char *item4 = (char*)sqlite3_column_text(statement, 4);
            NSString *str4 = [[NSString alloc]initWithUTF8String:item4];
            
            char *item5 = (char*)sqlite3_column_text(statement, 5);
            NSString *str5 = [[NSString alloc]initWithUTF8String:item5];
            
            userInfo = @{
                           @"id": str,
                           @"account": str1,
                           @"password": str2,
                           @"loaction_city": str3,
                           @"latitude": str4,
                           @"longitude": str5
                           };
            
        }
    }
    sqlite3_close(db);
    
    return userInfo;
}

- (BOOL)sqlHasLoactionCity
{
    sqlite3_stmt * statement;
    NSString *sqlQuery = @"SELECT loaction_city FROM userInfo";
    
    NSString *loaction;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *item = (char*)sqlite3_column_text(statement, 0);
            loaction = [[NSString alloc]initWithUTF8String:item];
        }
    }
    sqlite3_close(db);
    
    return [[loaction stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0;
}

- (void)updateUserInfoByLoaction:(NSString *const)loaction
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE userInfo SET 'loaction_city'='%@'", loaction];
    if ([self execSql:sql]) {
        loaction_city = loaction;
    }
}

- (BOOL)insertUserInfoByLoaction:(NSString *const)loaction
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO userInfo('account', 'password', 'loaction_city', 'latitude', 'longitude') VALUES('%@','%@', '%@', '%@', '%@')", @"", @"", loaction, @"", @""];
    return [self execSql:sql];
}

@end
