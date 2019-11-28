//
//  ModelShowViewController.m
//  闪屏
//
//  Created by 邱读书 on 2019/11/15.
//  Copyright © 2019 邱读书. All rights reserved.
//

#import "ModelShowViewController.h"
#import "WTPresentTransition.h"

@interface ModelShowViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ModelShowViewController

- (instancetype)initWithGroupId:(NSString *)groupId{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        
    }
    return self;

}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [WTPresentTransition transitionWithTransitionType:PresentOneTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [WTPresentTransition transitionWithTransitionType:PresentOneTransitionTypeDismiss];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    

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
