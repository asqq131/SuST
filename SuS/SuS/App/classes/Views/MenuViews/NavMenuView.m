//
//  ZWShareMenuView.m
//  ZW-WeChat
//
//  Created by HZwu on 14-9-14.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#define kItemSize CGSizeMake(55, 55)
#define kOnePageCount 8
#define kColumnCount 4
#define kRowCount 2

#import "NavMenuView.h"
//#import "GMGridView.h"
//#import "GMGridViewLayoutStrategies.h"

@interface NavMenuView () <UIScrollViewDelegate>
{
    __weak UIPageControl *_pageControl;
}

@end

@implementation NavMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 185, CGRectGetWidth(self.frame), 20)];
        pageControl.currentPage = 0;
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.userInteractionEnabled = NO;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    for (int index = 0; index < _dataArray.count; index++) {
        NSInteger paddingX = 20;
        NSInteger paddingY = 15;
        NSInteger page = index / kOnePageCount; // 所在页数
        NSInteger column = index % kColumnCount; // 所在列
        NSInteger row = index / kColumnCount - kRowCount * page; // 所在行
        
        UIButton *appButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [appButton setImage:[UIImage imageNamed:_dataArray[index][@"icon"]] forState:UIControlStateNormal];
        [appButton setTitle:_dataArray[index][@"description"] forState:UIControlStateNormal];
        [appButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [appButton addTarget:self action:@selector(appButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        appButton.backgroundColor = [UIColor clearColor];
        appButton.titleLabel.font = [UIFont systemFontOfSize:11];
        appButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        appButton.titleEdgeInsets = UIEdgeInsetsMake(kItemSize.width + 20, -kItemSize.width, 0, 0); // 设置文字偏移，使得文字在图片下方
        appButton.tag = index;
        appButton.frame = CGRectMake(paddingX + (page * CGRectGetWidth(self.frame)) + column * (kItemSize.width + paddingX), paddingY + row * (kItemSize.height + 2 * paddingY), kItemSize.width, kItemSize.height);
        [_scrollView addSubview:appButton];
    }
    
    // 求两个数的余数和商
    // -->result.quot(商值)
    // -->result.rem (余数)
    div_t result = div(_dataArray.count, kOnePageCount); // 商值加1就是总页数
    _scrollView.contentSize = CGSizeMake((++result.quot) * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    _pageControl.numberOfPages = result.quot;
}

- (void)appButtonClicked:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(NavMenuViewItemButtonClicked:index:)]) {
        [_delegate NavMenuViewItemButtonClicked:sender index:sender.tag];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / CGRectGetWidth(self.frame);
    _pageControl.currentPage = currentPage;
}

@end
