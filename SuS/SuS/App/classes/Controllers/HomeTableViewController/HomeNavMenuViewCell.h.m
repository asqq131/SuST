//
//  HomeTableViewCell.m
//  SuS
//
//  Created by HZwu on 14-11-27.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "HomeNavMenuViewCell.h"
#import "NavMenuView.h"

@interface HomeNavMenuViewCell () <NavMenuViewDelegate>

@end

@implementation HomeNavMenuViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView
{
    // shareMenuView
    NSArray *dataArray = @[
                           @{
                               @"icon": @"sharemore_pic",
                               @"description": @"美食"
                               },
                           @{
                               @"icon": @"sharemore_video",
                               @"description": @"小吃快餐"
                               },
                           @{
                               @"icon": @"sharemore_location",
                               @"description": @"休闲娱乐"
                               },
                           @{
                               @"icon": @"sharemore_friendcard",
                               @"description": @"全部分类"
                               },
                           @{
                               @"icon": @"sharemore_myfav",
                               @"description": @"团购"
                               },
                           @{
                               @"icon": @"sharemore_wxtalk",
                               @"description": @"订酒店"
                               },
                           @{
                               @"icon": @"sharemore_videovoip",
                               @"description": @"订外卖"
                               },
                           @{
                               @"icon": @"sharemore_voiceinput",
                               @"description": @"看电影"
                               },
                           @{
                               @"icon": @"sharemore_openapi",
                               @"description": @"丽人"
                               },
                           @{
                               @"icon": @"sharemore_openapi",
                               @"description": @"亲子"
                               }
                           ];
    NavMenuView *navMenuView = [[NavMenuView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    navMenuView.delegate = self;
    navMenuView.dataArray = dataArray;
    [self.contentView addSubview:navMenuView];
}

- (void)NavMenuViewItemButtonClicked:(UIButton *)sender index:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(NavMenuViewItemButtonClicked:index:)]) {
        [self.delegate NavMenuViewItemButtonClicked:sender index:index];
    }
}

@end
