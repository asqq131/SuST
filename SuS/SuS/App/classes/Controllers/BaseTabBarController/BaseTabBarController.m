//
//  ZWBaseTabBarController.m
//  ZW-WeChat
//
//  Created by HZwu on 14-9-12.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "BaseTabBarController.h"

#import "BaseNavigationController.h"
#import "HomeTableViewController.h"
#import "BuyTableViewController.h"
#import "DiscoverTableViewController.h"
#import "ProfileTableViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (id)init
{
    if (self = [super init]) {
        // 主界面
        HomeTableViewController *homeController = [[HomeTableViewController alloc] init];
        homeController.title = NSLocalizedStringFromTable(@"首页", @"HomeTableViewController", @"home");
        homeController.tabBarItem.image = [UIImage imageNamed:@"WeChat.png"];
        BaseNavigationController *homeNavigationController = [[BaseNavigationController alloc] initWithRootViewController:homeController];
        
        // 团购
        BuyTableViewController *buyController = [[BuyTableViewController alloc] init];
        buyController.title = NSLocalizedStringFromTable(@"团购", @"BuyTableViewController", @"buy");
        buyController.tabBarItem.image = [UIImage imageNamed:@"Contact.png"];
        BaseNavigationController *buyNavigationController = [[BaseNavigationController alloc] initWithRootViewController:buyController];
        
        // 发现
        DiscoverTableViewController *discoverController = [[DiscoverTableViewController alloc] init];
        discoverController.title = NSLocalizedStringFromTable(@"发现", @"DiscoverTableViewController", @"discover");
        discoverController.tabBarItem.image = [UIImage imageNamed:@"SNS.png"];
        BaseNavigationController *discoverNavigationController = [[BaseNavigationController alloc] initWithRootViewController:discoverController];
        
        // 自己
        ProfileTableViewController *profileController = [[ProfileTableViewController alloc] init];
        profileController.title = NSLocalizedStringFromTable(@"我", @"ProfileTableViewController", @"profile");
        profileController.tabBarItem.image = [UIImage imageNamed:@"Profile.png"];
        BaseNavigationController *profileNavigationController = [[BaseNavigationController alloc] initWithRootViewController:profileController];
        
        self.viewControllers = @[homeNavigationController, buyNavigationController, discoverNavigationController, profileNavigationController];
        
        // setup UI Image
        UIColor *color = [UIColor whiteColor];//[UIColor colorWithRed:0.176 green:0.576 blue:0.980 alpha:1.000];
        [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-background"]];
        [self.tabBar setSelectedImageTintColor:color];
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
