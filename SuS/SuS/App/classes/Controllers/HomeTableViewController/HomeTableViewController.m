//
//  ZWContactTableViewController.m
//  ZW-WeChat
//
//  Created by HZwu on 14-9-12.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#define kNavMenuViewHeight 216
#define kTableViewCellDefaultHeight 80
#define kNavMenuCellID @"navMenuCell"
#define kTDRCellID @"TDRCell"
#define kBusinessCellID @"businessCell"

#import "HomeTableViewController.h"
#import "HomeNavMenuViewCell.h"
#import "HomeTDRecommendViewCell.h"
#import "HomeBusinessTableCellTableViewCell.h"
#import "SuSNetwork.h"

#import "WebViewController.h"
#import "SuSUser.h"
#import "LocationCityTableViewController.h"

@interface HomeTableViewController () <TDRClickDelegate, SuSNetworkDelegate, NavMenuCellDelegate>
{
    NSArray *_businesses;
    UIActivityIndicatorView *_activityIndicatorView;
}

@end

@implementation HomeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame : CGRectMake(0, 0, 32, 32)] ;
    [_activityIndicatorView setCenter: self.view.center];
    [_activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.color = [UIColor redColor];
    [self.view addSubview:_activityIndicatorView];
    
    // 去掉cell间隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma 顶端导航
- (void)createNavBar
{
    //导航栏左边按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 50, 30);
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitle:[NSString stringWithFormat:@"%@", loaction_city] forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor orangeColor]];
    [leftButton addTarget:self action:@selector(moveToCicyLocation) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:11];
    leftButton.layer.masksToBounds = YES;
    leftButton.layer.cornerRadius = 13;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(0, 0, 150, 30);
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setTitle:@"输入商店名、地名" forState:UIControlStateNormal];
    [titleButton setBackgroundColor:[UIColor orangeColor]];
    [titleButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(moveToSearch) forControlEvents:UIControlEventTouchUpInside];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    titleButton.layer.masksToBounds = YES;
    titleButton.layer.cornerRadius = 13;
    titleButton.titleLabel.font = [UIFont systemFontOfSize:11];
    self.navigationItem.titleView = titleButton;
}

- (void)networkRequest
{
    [_activityIndicatorView startAnimating];
    
    // 发送点评网请求
    NSString *paramsString = [NSString stringWithFormat:@"city=%@&sort=2", loaction_city];
    SuSNetwork *client = [SuSNetwork client];
    client.delegate = self;
    [client requestByDPurl:@"v1/business/find_businesses" paramsString:paramsString parameters:nil cachePolicy:NSURLRequestUseProtocolCachePolicy success:^(BOOL empty) {
        [_activityIndicatorView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [_activityIndicatorView stopAnimating];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self createNavBar];
    [self networkRequest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (2 + _businesses.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellID = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kNavMenuCellID];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:kTDRCellID];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kBusinessCellID];
    }
    
    if (cell == nil) {
        if (indexPath.row == 0) {
            HomeNavMenuViewCell *navMenuCell = [[HomeNavMenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kNavMenuCellID];
            navMenuCell.delegate = self;
            cell = navMenuCell;
            
        } else if (indexPath.row == 1){
            HomeTDRecommendViewCell *TDRcell = [[HomeTDRecommendViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTDRCellID];
            TDRcell.delegate = self;
            cell = TDRcell;
            
        } else {
            HomeBusinessTableCellTableViewCell *businessCell = [[HomeBusinessTableCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kBusinessCellID];
            if (indexPath.row < _businesses.count) {
                businessCell.dataDict = _businesses[indexPath.row];
            }
            cell = businessCell;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kNavMenuViewHeight;
    } else if (indexPath.row == 1) {
        return kTDRCellHeight;
    }
    
    return kTableViewCellDefaultHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger businessIndex = indexPath.row - 2;
    if (businessIndex >= 0) {
        WebViewController *webViewController = [[WebViewController alloc] initWithUrl:_businesses[businessIndex][@"business_url"]];
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

#pragma 点评网络数据返回
- (void)DPPopulateResponse:(id)data
{
    _businesses = data[@"businesses"];
    [self.tableView reloadData];
}

#pragma 导航分类栏按钮点击事件
- (void)NavMenuViewItemButtonClicked:(UIButton *)sender index:(NSInteger)index
{
    DLog(@"clicked appButton by %d", index);
}

#pragma 今日推荐栏点击事件
- (void)TDRButtonClicked:(UIButton *)button
{
    DLog(@"button tag = %d", button.tag);
}

- (void)moveToSearch
{
    DLog(@"moveToSearch");
}

#pragma 前往重新城市定位
- (void)moveToCicyLocation
{
    LocationCityTableViewController *locationController = [[LocationCityTableViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:locationController animated:YES];
}

@end
