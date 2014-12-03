//
//  UIViewController+REFrostedView.m
//  EIM
//
//  Created by user on 14-8-27.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "UIViewController+REFrostedView.h"
#import "WTSNavigationController.h"

@implementation UIViewController (REFrostedView)

- (void)addLeftMenuItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(WTSNavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

@end
