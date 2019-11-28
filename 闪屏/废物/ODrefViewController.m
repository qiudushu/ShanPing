//
//  ODrefViewController.m
//  闪屏
//
//  Created by 邱读书 on 16/4/22.
//  Copyright © 2016年 邱读书. All rights reserved.
//

#import "ODrefViewController.h"
#import "ODRefreshControl.h"

@interface ODrefViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArr;
    NSArray *midArr;
}
@property (nonatomic, strong) ODRefreshControl *myRefreshControl;
@property (assign, nonatomic) BOOL isLoading;
@end

@implementation ODrefViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataArr = @[@"草泥马",@"草泥马",@"草泥马"];
    midArr = @[@"阿西吧",@"阿西吧",@"阿西吧"];
    
//    _myRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.mainTab];
//    [_myRefreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
//    [self refresh];
//
}
//- (void)refresh{
//    if (_isLoading) {
//        return;
//    }
//    if (!_isLoading)
//    {
//        [self.main beginLoading];
//    }
//    _isLoading = YES;
//    __weak typeof(self) weakSelf = self;
//    [[Coding_NetAPIManager sharedManager] request_CommitInfo_WithUserGK:_ownerGK projectName:_projectName commitId:_commitId andBlock:^(CommitInfo *data, NSError *error) {
//        weakSelf.isLoading = NO;
//        [weakSelf.view endLoading];
//        [weakSelf.myRefreshControl endRefreshing];
//        if (data) {
//            weakSelf.curCommitInfo = data;
//            [weakSelf configListGroups];
//            [weakSelf.myTableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
//        }
//        [weakSelf.view configBlankPage:EaseBlankPageTypeView hasData:(weakSelf.curCommitInfo.commitDetail != nil) hasError:(error != nil) reloadButtonBlock:^(id sender) {
//            [weakSelf refresh];
//        }];
//    }];
//}
#pragma mark - TableView的数据源代理方法实现
/**
 *  返回每组有多少行的代理方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
/**
 *  返回每一行Cell的代理方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 初始化Cell
    // 1.1 设置Cell的重用标识
    static NSString *ID = @"cell";
    // 1.2 去缓存池中取Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 1.3 若取不到便创建一个带重用标识的Cell
    if (cell == nil)
    {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    cell.textLabel.text = dataArr[indexPath.row];
    cell.textLabel.text = midArr[indexPath.row];
    return cell;
}


@end
