//
//  ModelPresentViewController.m
//  闪屏
//
//  Created by 邱读书 on 2019/11/15.
//  Copyright © 2019 邱读书. All rights reserved.
//

#import "ModelPresentViewController.h"

#import "ModelShowViewController.h"

@interface ModelPresentViewController ()

@end

@implementation ModelPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ModelShowViewController *vc = [[ModelShowViewController alloc]initWithGroupId:@"2"];
    [self presentViewController:vc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
