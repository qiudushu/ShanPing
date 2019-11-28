//
//  ThreeViewController.m
//  思无邪
//
//  Created by guo on 15/10/8.
//  Copyright © 2015年 qiudushu. All rights reserved.
//

#import "ThreeViewController.h"
//#import "GDMapViewController.h"
//#import "LocalViewController.h"
//#import "Local2ViewController.h"

#import "ModelPresentViewController.h"
#import "WkWebViewController.h"


@interface ThreeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *MapView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _dataArray = @[
                   @{@"name":@"高德",
                     @"description":@"简介"},
                   @{@"name":@"百度地图",
                     @"description":@"高德地图定位"},
                   @{@"name":@"高德地图定位卧槽",
                     @"description":@"地图定位"},
                   @{@"name":@"地图导航",
                     @"description":@"地图导航"},
                   @{@"name":@"卧槽",
                     @"description":@"卧槽简介"},
                   @{@"name":@"复制",
                     @"description":@"长按复制可以到APP粘贴"},
                   @{@"name":@"模态半屏控制器",
                     @"description":@""},
                   @{@"name":@"wkWebview",
                     @"description":@""},


                   ];

}
#pragma mark - TableView的数据源代理方法实现
/**
 *  返回每组有多少行的代理方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
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
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    cell.textLabel.text = [[_dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.detailTextLabel.text = [[_dataArray objectAtIndex:indexPath.row] valueForKey:@"description"];
    return cell;
}
/**
 *  点击选中的cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0)
//    {
//        GDMapViewController *gd = [[GDMapViewController alloc]init];
//        gd.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:gd animated:YES];
//    }
//    else if (indexPath.row == 1)
//    {
//        LocalViewController *gd = [[LocalViewController alloc]init];
//        gd.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:gd animated:YES];
//    }
//    else if (indexPath.row == 2)
//    {
//        Local2ViewController *gd = [[Local2ViewController alloc]init];
//        gd.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:gd animated:YES];
//    }
//    else if (indexPath.row == 5)
//    {
//        NSLog(@"打印   %@",[[_dataArray objectAtIndex:indexPath.row] valueForKey:@"description"]);
//    }
    
    
    if (indexPath.row == 6) {
        ModelPresentViewController *modelVc = [[ModelPresentViewController alloc]init];
        modelVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:modelVc animated:YES];
    }
    
    if (indexPath.row == 7) {
        WkWebViewController *webVc = [[WkWebViewController alloc]init];
        webVc.hidesBottomBarWhenPushed = YES;
        webVc.navigationController.navigationBar.hidden = YES;
        [self.navigationController pushViewController:webVc animated:YES];
    }
    
}


@end
