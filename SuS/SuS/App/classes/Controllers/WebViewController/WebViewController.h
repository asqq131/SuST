//
//  WebViewController.h
//  SuS
//
//  Created by HZwu on 14-12-1.
//  Copyright (c) 2014年 HZwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, weak) UIWebView *webView;

- (id)initWithUrl:(NSString *)urlString;

@end
