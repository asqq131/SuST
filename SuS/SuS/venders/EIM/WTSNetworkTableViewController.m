//
//  WTSNetworkTableViewController.m
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "WTSNetworkTableViewController.h"

#import "NITableViewModel+WTSNetwork.h"

@interface WTSNetworkTableViewController ()

@end

@implementation WTSNetworkTableViewController

@synthesize model = _model, actions = _actions;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Default actions
        _actions = [[NITableViewActions alloc] initWithTarget:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self.model;
    
    // What we're doing here is known as "delegate chaining". It uses the message forwarding
    // functionality of Objective-C to insert the actions object between the table view
    // and this controller. The actions object forwards UITableViewDelegate methods along and
    // selectively intercepts methods required to make user interactions work.
    //
    // Experiment: try commenting out this line. You'll notice that you can no longer tap any of
    // the cells in the table view and that they no longer show the disclosure accessory types.
    // Cool, eh? That this functionality is all provided to you in one line should make you
    // heel-click.
    self.tableView.delegate = [self.actions forwardingTo:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.model load:NSURLRequestUseProtocolCachePolicy
                more:NO
             success:^(BOOL empty) {
                 if(empty) {
                     // TODO show empty view
                 }
                 [weakSelf.tableView reloadData];
             } failure:^(NSError *error) {
                 // TODO show error
             }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    [self.model cancelRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
