
//
//  showChildViewController.m
//  闪屏
//
//  Created by 邱读书 on 2018/10/17.
//  Copyright © 2018 邱读书. All rights reserved.
//

#import "showChildViewController.h"
#import "Common.h"
#import <Masonry.h>
#import "childAViewController.h"
#import "childBViewController.h"

@interface showChildViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIScrollView *mainScrollview;
@property (nonatomic,assign) NSInteger Index;
@end

@implementation showChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
        
    self.Index = 0;

    //主view
    UIScrollView *mainScrollview = [[UIScrollView alloc]init];
    mainScrollview.delegate = self;
    mainScrollview.backgroundColor = [UIColor greenColor];
    self.mainScrollview = mainScrollview;
    mainScrollview.contentSize = CGSizeMake(kWidth * 2, kHeight);
    mainScrollview.pagingEnabled = YES;
    mainScrollview.showsVerticalScrollIndicator = NO;
    mainScrollview.showsHorizontalScrollIndicator = NO;
    mainScrollview.bounces = NO;
    [self.view addSubview:mainScrollview];
    [mainScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(self.view).mas_offset(-34);
        make.top.mas_equalTo(self.view).mas_offset(20);
    }];
    
    //添加主控制器
    childAViewController *AVC = [[childAViewController alloc]init];
    childBViewController *bVC = [[childBViewController alloc]init];
    [self addChildViewController:AVC];
    [self addChildViewController:bVC];
    
    AVC.view.frame = CGRectMake(0, 0, kWidth,kHeight - 54);
    bVC.view.frame = CGRectMake(kWidth, 0, kWidth,kHeight - 54);
    [mainScrollview addSubview:AVC.view];
    [mainScrollview addSubview:bVC.view];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSInteger currentIndex = scrollView.contentOffset.x/kWidth;
//    NSLog(@"=====%ld",currentIndex);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentIndex = scrollView.contentOffset.x/kWidth;
    NSLog(@"=====%ld",currentIndex);
    self.Index = currentIndex;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.Index == 0) {
        self.Index = 1;
    }else{
        self.Index = 0;
    }
    [self.mainScrollview setContentOffset:CGPointMake(self.Index * kWidth, 0) animated:YES];
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
