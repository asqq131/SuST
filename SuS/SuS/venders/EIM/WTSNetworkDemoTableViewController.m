//
//  WTSNetworkDemoTableViewController.m
//  EIM
//
//  Created by user on 14-8-26.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "WTSNetworkDemoTableViewController.h"

#import "NITableViewActions.h"
#import "NICellFactory.h"
#import "NITableViewModel+WTSNetwork.h"
#import "WTSNetworkDemoTableViewModel.h"

@interface WTSNetworkDemoTableViewController ()
@property (nonatomic, retain) WTSNetworkDemoTableViewModel* model;

// The actions are stored in a separate object from the model.
@property (nonatomic, retain) NITableViewActions* actions;
@end

@implementation WTSNetworkDemoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.model = [[WTSNetworkDemoTableViewModel alloc] initWithDelegate:(id)[NICellFactory class]];
//        _model = [[NITableViewModel alloc] initWithSectionedArray:tableContents
//                                                         delegate:(id)[NICellFactory class]];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
