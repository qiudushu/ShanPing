//
//  ScanViewController.m
//  TicketSuper
//
//  Created by 邱读书 on 15/11/11.
//  Copyright © 2015年 FanKing. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()<UIWebViewDelegate>
@end
@implementation ScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"扫描结果";
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view from its nib.
    mainWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, Getwidth, GetHeight - 64)];
    mainWebView.scalesPageToFit = YES;
    mainWebView.delegate = self;
    [self.view addSubview:mainWebView];
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.mScanUrl]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [mainWebView loadRequest:request];
    
}
#pragma mark -- webView的代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}
/**
 *  关闭界面横向滑动
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

@end
