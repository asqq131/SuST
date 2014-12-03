//
//  HomeTDRecommendViewCell.m
//  SuS
//
//  Created by HZwu on 14-11-28.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "HomeTDRecommendViewCell.h"

@implementation HomeTDRecommendViewCell

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
    // header
    UIView *headerSpaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), kSpaceViewHeight)];
    headerSpaceView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.7];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.contentView.frame), kSpaceViewHeight)];
    titleLabel.text = @"今日推荐";
    titleLabel.font = [UIFont systemFontOfSize:12];
    [headerSpaceView addSubview:titleLabel];
    [self.contentView addSubview:headerSpaceView];
    
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button0 setBackgroundImage:[UIImage imageNamed:@"TDR.png"] forState:UIControlStateNormal];
    [button0 setTitle:@"Show photo" forState:UIControlStateNormal];
    [button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button0.frame = CGRectMake(0, CGRectGetMaxY(headerSpaceView.frame), kButtonSize.width, kButtonSize.height);
    button0.tag = 0;
    [button0 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button0];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:@"TDR.png"] forState:UIControlStateNormal];
    [button1 setTitle:@"Show photo" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(CGRectGetMaxX(button0.frame), CGRectGetMaxY(headerSpaceView.frame), kButtonSize.width, kButtonSize.height);
    button1.tag = 1;
    [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:[UIImage imageNamed:@"TDR.png"] forState:UIControlStateNormal];
    [button2 setTitle:@"Show photo" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.frame = CGRectMake(0, CGRectGetMaxY(button0.frame), kButtonSize.width, kButtonSize.height);
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setBackgroundImage:[UIImage imageNamed:@"TDR.png"] forState:UIControlStateNormal];
    [button3 setTitle:@"Show photo" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button3.frame = CGRectMake(CGRectGetMaxX(button0.frame), CGRectGetMaxY(button1.frame), kButtonSize.width, kButtonSize.height);
    button3.tag = 3;
    [button3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button3];
    
    // footer
    UIView *footerSpaceView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button2.frame), CGRectGetWidth(self.contentView.frame), kSpaceViewHeight)];
    footerSpaceView.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.7];
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.contentView.frame), kSpaceViewHeight)];
    titleLabel1.text = @"猜你喜欢";
    titleLabel1.font = [UIFont systemFontOfSize:12];
    [footerSpaceView addSubview:titleLabel1];
    [self.contentView addSubview:footerSpaceView];
}

- (void)buttonClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(TDRButtonClicked:)]) {
        [self.delegate TDRButtonClicked:button];
    }
}

@end
