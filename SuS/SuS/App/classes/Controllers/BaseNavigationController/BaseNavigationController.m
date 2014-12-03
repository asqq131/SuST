//
//  ZWBaseNavigationController.m
//  ZW-WeChat
//
//  Created by HZwu on 14-9-12.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIImage+IMTransform.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

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
    
    // 设置导航栏半透明背景
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"tabbar-background@2x.png"];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            backgroundImage = [UIImage scaleToSize:backgroundImage size:CGSizeMake(self.view.frame.size.width, 64)];
        } else {
            backgroundImage = [UIImage scaleToSize:backgroundImage size:CGSizeMake(self.view.frame.size.width, 44)];
        }
        
        [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    self.navigationBar.titleTextAttributes = attributes;
    
//    self.navigationBar.barStyle = UIBarStyleDefault;
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
