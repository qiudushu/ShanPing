//
//  FirstViewController.m
//  思无邪
//
//  Created by guo on 15/9/16.
//  Copyright (c) 2015年 qiudushu. All rights reserved.
//

#import "FirstViewController.h"
#import "NoDataViewController.h"
#import <Masonry.h>
#import "Common.h"
#import "MyHelper.h"
#import "HJDanmaKuView.h"
#import "WTCBarrageModel.h"
#import "NodataShowTableViewCell.h"
#import "showChildViewController.h"


@interface FirstViewController ()<HJDanmakuViewDelegate,HJDanmakuViewDateSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)HJDanmakuView *danmakuView;
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,weak)UITableView *mainTabView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *lanView;

@end

@implementation FirstViewController

- (void)sendContent:(id)sender{
    
    [self.danmakuView play];
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(addDanmuA) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] run];
}

- (void)addDanmuA{
    self.index = self.index + 1;
    
    WTCBarrageModel *danmaku = [[WTCBarrageModel alloc] initWithType:HJDanmakuTypeLR];
    danmaku.text = @"邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书";
    danmaku.barrageFont = [UIFont systemFontOfSize:16];
    
    WTCBarrageModel *danmaku1 = [[WTCBarrageModel alloc] initWithType:HJDanmakuTypeLR];
    danmaku1.text = [NSString stringWithFormat:@"😊😊😊😊===>%ld",self.index];
    danmaku1.barrageFont = [UIFont systemFontOfSize:16];
    
    [self.danmakuView sendDanmakus:[NSMutableArray arrayWithObjects:danmaku,danmaku1,danmaku,danmaku1,danmaku1,danmaku,danmaku1,danmaku1,danmaku,danmaku1, nil]];

}

- (void)webAction:(id)sender{
//    [self.danmakuView stop];
//    [self.danmakuView clearScreen];
    
    [self.dataArray addObject:@"3"];
    [self.mainTabView reloadData];

}

#pragma mark - 弹幕代理方法

- (CGFloat)danmakuView:(HJDanmakuView *)danmakuView widthForDanmaku:(HJDanmakuModel *)danmaku{
    WTCBarrageModel *model = (WTCBarrageModel *)danmaku;
    return [model.text sizeWithAttributes:@{NSFontAttributeName: model.barrageFont}].width + 1.0f;
//    return 30;
}

- (HJDanmakuCell *)danmakuView:(HJDanmakuView *)danmakuView cellForDanmaku:(HJDanmakuModel *)danmaku{
    HJDanmakuCell *cell = [danmakuView dequeueReusableCellWithIdentifier:@"barrage"];
    cell.backgroundColor = [UIColor orangeColor];
    WTCBarrageModel *model = (WTCBarrageModel *)danmaku;
    cell.textLabel.text = model.text;
    cell.textLabel.font = model.barrageFont;
    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.index = 1000;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"跑起来" style:UIBarButtonItemStyleDone target:self action:@selector(sendContent:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"停下来" style:UIBarButtonItemStyleDone target:self action:@selector(webAction:)];

    
//    HJDanmakuConfiguration *config = [[HJDanmakuConfiguration alloc] initWithDanmakuMode:HJDanmakuModeLive];
//    config.numberOfLines = 3;//弹道
//    config.tolerance = 4.0;//
//    config.duration = 10.0f;//设置弹幕离开屏幕时间
//
//
//    HJDanmakuView *danmakuView = [[HJDanmakuView alloc] initWithFrame:CGRectMake(0, 140, kWidth, 150) configuration:config];
//    self.danmakuView = danmakuView;
//    danmakuView.dataSource = self;
//    danmakuView.delegate = self;
//
//    WTCBarrageModel *danmaku = [[WTCBarrageModel alloc] initWithType:HJDanmakuTypeLR];
//    danmaku.text = @"邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书邱读书";
//    danmaku.barrageFont = [UIFont systemFontOfSize:16];
//
//    WTCBarrageModel *danmaku1 = [[WTCBarrageModel alloc] initWithType:HJDanmakuTypeLR];
//    danmaku1.text = @"😊我烦表情";
//    danmaku1.barrageFont = [UIFont systemFontOfSize:16];
//
//    [danmakuView prepareDanmakus:[NSMutableArray arrayWithObjects:danmaku,danmaku1,danmaku,danmaku1,danmaku1,danmaku,danmaku1,danmaku1,danmaku,danmaku1, nil]];
//    [danmakuView registerClass:[HJDanmakuCell class] forCellReuseIdentifier:@"barrage"];
//    [self.view addSubview:danmakuView];

    
         
    
    
//    //渐变颜色view
//    UIView *hexView = [[UIView alloc]init];
//    hexView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:hexView];
//    [hexView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(60);
//        make.left.mas_equalTo(20);
//        make.right.mas_equalTo(self.view).mas_offset(-20);
//        make.top.mas_equalTo(60);
//    }];
//
//    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1.0, 0);
//    gradientLayer.shadowOffset = CGSizeMake(0, 2);
//    gradientLayer.cornerRadius = 4;
//    gradientLayer.frame = CGRectMake(0, 0, kWidth - 40, 60);
//    [hexView.layer addSublayer:gradientLayer];
//
//    gradientLayer.colors = @[(id)[MyHelper colorWithHexString:@"6DE1FF"].CGColor,(id)[MyHelper colorWithHexString:@"3D8EFF"].CGColor];
//    gradientLayer.shadowColor = [MyHelper colorWithHexString:@"38B1FC"].CGColor;
//
//
//
//    int i = 0;
//    for(NSString *fontfamilyname in [UIFont familyNames])
//    {
//        i +=1;
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"%d＝＝＝＝＝＝>%@",i,fontName);
//        }
//    }
//
//
//    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
//    NSLog(@"-BID--%@---",bundleIdentifier);
//
//    if([MyHelper connectedToNetwork])
//    {
//        NSLog(@"连着网的");
//    }
//    else
//    {
//        NSLog(@"断着网的");
//    }
    
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
//
//    UITableView *mainTabView = [[UITableView alloc]init];
//    self.mainTabView = mainTabView;
//    mainTabView.dataSource = self;
//    mainTabView.delegate = self;
//    [mainTabView registerClass:[NodataShowTableViewCell class] forCellReuseIdentifier:@"123"];
//    [self.view addSubview:mainTabView];
//    [mainTabView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.left.right.mas_equalTo(self.view);
//    }];
    
    
//    UIView *redView = [[UIView alloc]init];
//    redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:redView];
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(self.view);
//        make.width.height.mas_equalTo(100);
//    }];
//
//    UIView *blueView = [[UIView alloc]init];
//    blueView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:blueView];
//    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(self.view);
//        make.width.height.mas_equalTo(150);
//    }];
//
//    [self.view bringSubviewToFront:redView];
    
    
    if (_lanView) {
        NSLog(@"11111111111");
    }
    if (self.lanView) {
        NSLog(@"222222222222");
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NodataShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    cell.textLabel.text = [NSString stringWithFormat:@"====%ld====",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NodataShowTableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 animations:^{
        selectCell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        selectCell.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            selectCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == (self.dataArray.count - 1)) {
//        [UIView animateWithDuration:0.5 animations:^{
//            //使用Make,它是相对于最原始的位置做的形变.
//            //self.imageV.transform = CGAffineTransformMakeTranslation(0, -100);
//            //相对于上一次做形变.
//            cell.transform = CGAffineTransformTranslate(cell.transform, -kWidth,0);
//        }];
        [UIView animateWithDuration:0.5 animations:^{
            cell.transform = CGAffineTransformTranslate(cell.transform, -kWidth,0);
        } completion:^(BOOL finished) {
            [cell setFrame:CGRectMake(0, 0, kWidth, 80)];
        }];
        
    }
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NoDataViewController *noDataViewController = [[NoDataViewController alloc]init];
//    noDataViewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:noDataViewController animated:YES];
    
    showChildViewController *mshowChildViewController = [[showChildViewController alloc]init];
    [self.navigationController pushViewController:mshowChildViewController animated:YES];

}

- (UIView *)lanView{
    if (!_lanView) {
        _lanView = [[UIView alloc]init];
        _lanView.backgroundColor = [UIColor orangeColor];
    }
    return _lanView;
}

@end
