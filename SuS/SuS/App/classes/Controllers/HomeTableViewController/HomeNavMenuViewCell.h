//
//  HomeTableViewCell.h
//  SuS
//
//  Created by HZwu on 14-11-27.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavMenuCellDelegate <NSObject>

- (void)NavMenuViewItemButtonClicked:(UIButton *)sender index:(NSInteger)index;

@end

/////////////////////////////////////////////////////////////

@interface HomeNavMenuViewCell : UITableViewCell

@property (nonatomic, assign) id<NavMenuCellDelegate> delegate;

@end
