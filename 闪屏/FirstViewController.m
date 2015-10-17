//
//  FirstViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"-BID--%@---",bundleIdentifier);
    
    if([MyHelper connectedToNetwork])
    {
        NSLog(@"连着网的");
    }
    else
    {
        NSLog(@"断着网的");
    }
    
}

@end
