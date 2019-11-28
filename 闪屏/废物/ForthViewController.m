//
//  ForthViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "ForthViewController.h"
#import "HADirect.h"

#import <AVOSCloud/AVOSCloud.h>

@interface ForthViewController ()<UIScrollViewDelegate>
{
    UIImageView *headerImgView;
    NSTimer *mTimer;
    int timeNum;
    UIPageControl * mPage;
    UIScrollView *pageScrollView;
}
@property (weak, nonatomic) IBOutlet UITableView *SetMainTabView;
@end

@implementation ForthViewController
- (void)GotoSettintg:(UIBarButtonItem *)sender
{
//    SetUpDetailViewController *setUp = [[SetUpDetailViewController alloc]init];
//    [self.navigationController pushViewController:setUp animated:YES];
}

/*
 * 向leadCloud 存储数据
 */
- (void)saveDataToCloud{
    
    //https://itunes.apple.com/us/app/zhi-hui-shu./id1255358463?ls=1&mt=8
    NSString *moveUrl = @"https://itunes.apple.com/us/app/zhi-hui-shu./id1255358463?ls=1&mt=8";
    AVObject *saveObject = [AVObject objectWithClassName:@"MoveInfo"];
    [saveObject setObject:@"1" forKey:@"type"];
    [saveObject setObject:moveUrl forKey:@"moveUrl"];
    [saveObject setObject:@"预留字段" forKey:@"left"];
    [saveObject save];

}

/*
 * 读取数据
 */
- (void)getSaveData{
    AVQuery *query = [AVQuery queryWithClassName:@"MoveInfo"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        AVObject *firstObject = objects.firstObject;
        NSLog(@"====%@===%@==%@===%@",objects,firstObject.className,firstObject,firstObject[@"localData"]);
        NSLog(@"1111111====>>>>>%@",firstObject[@"localData"][@"moveUrl"]);
        NSString *scoreUrl = firstObject[@"localData"][@"moveUrl"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scoreUrl]];
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"SetUp" style:UIBarButtonItemStyleDone target:self action:@selector(GotoSettintg:)];
    [MyHelper setExtraCellLineHidden:self.SetMainTabView];
    [MyHelper setExtraCellPixelExcursion:self.SetMainTabView];

    /*
     * 向leadCloud 存储数据
     */
//    [self saveDataToCloud];
    
    
    /**
     *  头像
     */
    self.SetMainTabView.contentInset =  UIEdgeInsetsMake(200, 0, 0, 0);
    headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -200, Getwidth, 200)];
    headerImgView.image = [UIImage imageNamed:@"user_0.jpg"];
    [self.SetMainTabView addSubview:headerImgView];
    
    /**
     广告页
     */
    pageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Getwidth, 150)];
    pageScrollView.backgroundColor = [UIColor orangeColor];
    pageScrollView.showsHorizontalScrollIndicator = NO;
    pageScrollView.showsVerticalScrollIndicator = NO;
    pageScrollView.bounces = NO;
    pageScrollView.scrollsToTop = NO;
    pageScrollView.pagingEnabled = YES;
    pageScrollView.tag = 9999;
//    self.SetMainTabView.tableHeaderView = pageScrollView;
    
    UIImageView *pageImageView;
    for (int i = 0; i < 3; i++)
    {
        pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, 150)];
        pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_%d.jpg",i+2]];
        [pageScrollView addSubview:pageImageView];
    }
    pageScrollView.contentSize  = CGSizeMake(kWidth * 3, 150);
    
    mPage = [[UIPageControl alloc]initWithFrame:CGRectMake((kWidth- 200)/2, 120, 200, 20)];
    mPage.currentPageIndicatorTintColor = [UIColor redColor];
    mPage.pageIndicatorTintColor = [UIColor blackColor];
    mPage.numberOfPages = 3;
//    [self.SetMainTabView.tableHeaderView insertSubview:mPage atIndex:1];
    [self.SetMainTabView.tableHeaderView addSubview:mPage];
    
    HADirect *d = [HADirect direcWithtFrame:CGRectMake(0, 0, Getwidth, 150) ImageArr:@[@"user_1.jpg",@"user_2.jpg",@"user_3.jpg",@"user_4.jpg"] AndImageClickBlock:^(NSInteger index) {
        NSLog(@"点击的是当前  %ld  张照片 ",(long)index);
    }];
    self.SetMainTabView.tableHeaderView = d;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    timeNum = 0;
    mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(timerAction:)
                                            userInfo:nil
                                             repeats:YES];
}

/**
 *   定时器的操作
 *
 */
- (void)timerAction:(NSTimer *)sender
{
    timeNum ++;
    if (timeNum > 3)
    {
        timeNum = 0;
    }
    mPage.currentPage = timeNum;
    
    [UIView animateWithDuration:0.5 animations:^{
        [pageScrollView setContentOffset:CGPointMake(kWidth * mPage.currentPage, 0)];
    }];

}

#pragma mark - TableView的数据源代理方法实现
/**
 *  返回每组有多少行的代理方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
/**
 *  返回每一行Cell的代理方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1 初始化Cell
    // 1.1 设置Cell的重用标识
    static NSString *ID = @"cell";
    // 1.2 去缓存池中取Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 1.3 若取不到便创建一个带重用标识的Cell
    if (cell == nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"内容";
    return cell;
}
/**
 *  点击选中的cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"当前选中的是第 --- %ld 组 -- %ld 行--- ",indexPath.section,indexPath.row);
    
    [self getSaveData];
}
/**
 *  视图滑动的代理方法
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int x = scrollView.contentOffset.x;
    mPage.currentPage = x/kWidth;
    timeNum = 0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 9999)
    {
        int x = scrollView.contentOffset.x;
        
        mPage.currentPage = x/kWidth;
        
        timeNum = 0;
    }
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + 200)/2;
    
    if (yOffset < -200) {
        
        CGRect rect = headerImgView.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = Getwidth + fabs(xOffset)*2;
        
        headerImgView.frame = rect;
    }
    else
    {
        
    }
}

#pragma mark -- 视图消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    timeNum = 0;
    [mTimer invalidate];
}
@end
