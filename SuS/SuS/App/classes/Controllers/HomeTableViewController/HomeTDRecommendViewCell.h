//
//  HomeTDRecommendViewCell.h
//  SuS
//
//  Created by HZwu on 14-11-28.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TDRClickDelegate <NSObject>

- (void)TDRButtonClicked:(UIButton *)button;

@end

/*********************/

#define kButtonSize CGSizeMake(160, 50)
#define kSpaceViewHeight 30
#define kTDRCellHeight kButtonSize.height*2+kSpaceViewHeight*2

@interface HomeTDRecommendViewCell : UITableViewCell

@property (nonatomic, assign) id<TDRClickDelegate> delegate;

@end
