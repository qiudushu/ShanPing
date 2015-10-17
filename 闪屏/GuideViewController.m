//
//  GuideViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "GuideViewController.h"
#import "BaseTabbarViewController.h"
#import "AppDelegate.h"
@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GuideEndAction:(id)sender
{
    BaseTabbarViewController *tabBarController = [[BaseTabbarViewController alloc] init];
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController = tabBarController;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [userDefaults setObject:version forKey:@"ISFIRSTOPEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}


@end
