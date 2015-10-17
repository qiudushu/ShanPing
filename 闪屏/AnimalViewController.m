//
//  AnimalViewController.m
//  思无邪
//
//  Created by guo on 15/9/21.
//  Copyright © 2015年 qiudushu. All rights reserved.
//

#import "AnimalViewController.h"

@interface AnimalViewController ()
{
    UIButton *btn_animal;
}
@end

@implementation AnimalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /**
     *  <#Description#>
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    /**
     *  注册通知
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SEND_ANIMAL" object:nil];
    
    
    
    btn_animal = [[UIButton alloc] init];
    btn_animal.frame = CGRectMake(0, 0, 60, 50);
    [btn_animal setImage:[UIImage imageNamed:@"btn_Tabbar_Community"] forState:UIControlStateNormal];
    [btn_animal setImage:[UIImage imageNamed:@"btn_Tabbar_Community_on"] forState:UIControlStateSelected];
    [self.view addSubview:btn_animal];

    
    //添加放大效果
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray new];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [btn_animal.layer addAnimation:animation forKey:nil];

    
}

@end
