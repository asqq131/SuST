//
//  WTSNavigationController.m
//  EIM
//
//  Created by user on 14-8-27.
//  Copyright (c) 2014年 陈旭佳. All rights reserved.
//

#import "WTSNavigationController.h"

#import "WTSMenuViewController.h"
#import "REFrostedViewController.h"

@interface WTSNavigationController ()

@property (strong, readwrite, nonatomic) WTSMenuViewController *menuViewController;

@end

@implementation WTSNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}


@end
