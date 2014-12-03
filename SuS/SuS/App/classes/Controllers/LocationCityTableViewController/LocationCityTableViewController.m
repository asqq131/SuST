//
//  LocationCityTableViewController.m
//  SuS
//
//  Created by HZwu on 14-12-1.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "LocationCityTableViewController.h"
#import "BaseTabBarController.h"
#import "Constants.h"
#import "SuSNetwork.h"
#import "SuSSqlite.h"

@interface LocationCityTableViewController () <SuSNetworkDelegate>
{
    UIActivityIndicatorView *_activityIndicatorView;
    NSArray *_cities;
}

@end

@implementation LocationCityTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
                              initWithFrame : CGRectMake(0, 0, 32, 32)] ;
    [_activityIndicatorView setCenter: self.view.center];
    [_activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.color = [UIColor redColor];
    [self.view addSubview:_activityIndicatorView];
}

- (void)networkRequest
{
    [_activityIndicatorView startAnimating];
    
    // 发送点评网请求
//    NSString *paramsString = [NSString stringWithFormat:@"city=%@&sort=2", loaction_city];
    SuSNetwork *client = [SuSNetwork client];
    client.delegate = self;
    [client requestByDPurl:@"v1/metadata/get_cities_with_businesses" paramsString:nil parameters:nil cachePolicy:NSURLRequestUseProtocolCachePolicy success:^(BOOL empty) {
        [_activityIndicatorView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [_activityIndicatorView stopAnimating];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self networkRequest];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = _cities[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"loaction_city: %@", _cities[indexPath.row]);
    
    SuSSqlite *db = [SuSSqlite db];
    NSString *loaction = _cities[indexPath.row];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        DLog(@"第一次启动");
        if ([db insertUserInfoByLoaction:loaction]) {   // 设置全局的定位城市值
            loaction_city = loaction;
        }
        
    }else{
        DLog(@"已经不是第一次启动了");
        [db updateUserInfoByLoaction:loaction];
    }
    
    BaseTabBarController *tabBarController = [[BaseTabBarController alloc] init];
    tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:tabBarController animated:YES completion:nil];
}

- (void)DPPopulateResponse:(id)data
{
    _cities = data[@"cities"];
    [self.tableView reloadData];
}

@end
