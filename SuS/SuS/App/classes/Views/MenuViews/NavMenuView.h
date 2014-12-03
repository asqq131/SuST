//
//  ZWShareMenuView.h
//  ZW-WeChat
//
//  Created by HZwu on 14-9-14.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavMenuViewDelegate <NSObject>

- (void)NavMenuViewItemButtonClicked:(UIButton *)sender index:(NSInteger)index;

@end

/////////////////////////////////////////////////////////////

@interface NavMenuView : UIView

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) id<NavMenuViewDelegate> delegate;

@end
