//
//  WkWebViewController.m
//  闪屏
//
//  Created by 邱读书 on 2019/11/15.
//  Copyright © 2019 邱读书. All rights reserved.
//

#import "WkWebViewController.h"

@interface WkWebViewController ()

@end

@implementation WkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.s
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

@end
