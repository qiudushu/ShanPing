//
//  NoDataViewController.m
//  闪屏
//
//  Created by 邱读书 on 2018/10/16.
//  Copyright © 2018 邱读书. All rights reserved.
//

#import "NoDataViewController.h"
#import "NoDataTableViewCell.h"
#import <Masonry.h>
#import "showChildViewController.h"
#import "Common.h"

@interface NoDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *mainTableView;
@end

@implementation NoDataViewController

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
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoDataTableViewCell *noDataTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"NoDataTableViewCell"];
    return noDataTableViewCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    showChildViewController *mshowChildViewController = [[showChildViewController alloc]init];
    [self.navigationController pushViewController:mshowChildViewController animated:YES];

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
