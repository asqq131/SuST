//
//  WTSNetworkTableViewController.h
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NITableViewActions.h"

#import "WTSNetworkTableViewModel.h"


@interface WTSNetworkTableViewController : UITableViewController

@property(nonatomic, strong) WTSNetworkTableViewModel* model;
@property(nonatomic, strong) NITableViewActions* actions;

@end
