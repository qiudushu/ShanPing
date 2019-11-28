//
//  childAViewController.m
//  闪屏
//
//  Created by 邱读书 on 2018/10/17.
//  Copyright © 2018 邱读书. All rights reserved.
//

#import "childAViewController.h"
#import "NoDataTableViewCell.h"
#import <Masonry.h>


@interface childAViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *mainTableView;
@end

@implementation childAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UITableView *mainTableView = [[UITableView alloc]init];
    self.mainTableView = mainTableView;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainTableView registerClass:[NoDataTableViewCell class] forCellReuseIdentifier:@"NoDataTableViewCell"];
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(40);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        NoDataTableViewCell *noDataTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"NoDataTableViewCell"];
        return noDataTableViewCell;

    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
        }
        cell.contentView.backgroundColor = [UIColor orangeColor];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld===>",indexPath.row];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

@end
