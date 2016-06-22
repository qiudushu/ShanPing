//
//  ZYViewController.m
//  SearchBarTest
//
//  Created by Camille on 15/9/25.
//  Copyright (c) 2015年 zhy. All rights reserved.
//

#import "ZYViewController.h"

@interface ZYViewController ()

@end

@implementation ZYViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //数据源数组：源数据
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"qwert",@"uytgf",@"张三",@"李四",@"小五",@"王五",@"小四",@"张小妹",@"李明",@"qjhkio",@"asdrf", nil];
    
    //结果数据数组：
    _resultArray = [[NSMutableArray alloc] init];
    
    //设置搜索框
    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 44)];
    //设置搜索条件的标题
//    [searchBar setScopeButtonTitles:[[NSArray alloc]initWithObjects:@"按照首字符查询",@"按照包含字符查询", nil]];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    //设置显示控制器（显示搜索结果）：内部包含搜索结果的tableView
    //:NSObject
    
    //1.搜索框对象
    //2.管理要显示搜索结果的视图控制器
    UISearchDisplayController* searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    //设置显示控制器中 搜索结果表的数据源及代理
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    //设置显示控制器的代理
    searchDisplayController.delegate = self;
    
    
    
    //注册结果表的cell
    [searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark --- 搜索框的代理方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.frame = CGRectMake(0, 20, 320, 44);
    //显示或隐藏搜索界面
    [self.searchDisplayController setActive:YES];
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.frame = CGRectMake(0, 64, 320, 44);
    [self.searchDisplayController setActive:NO];
    return YES;
}

#pragma mark --- 显示控制器对应的代理方法
//以下两个方法的返回值为YES,刷新搜索结果表

//当搜索框中字符改变时，会调用，询问是否刷新结果表
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"1_____%s__",__FUNCTION__);
    //获取 搜索框的内容：controller.searchBar.text
    NSLog(@"搜索框的内容----%@____%@",controller.searchBar.text,searchString);
    //获取 搜索条件按钮对应的索引：
    int index = controller.searchBar.selectedScopeButtonIndex;
    NSLog(@"索引___%d",index);
    
    //每次搜索之前，清空结果表
    [_resultArray removeAllObjects];
    
    //遍历数组：源数组，目的：查找符合条件的搜索字符
    for (int i = 0; i<_dataArray.count; i++) {
        //源字符串
        NSString* sourceString = _dataArray[i];
        
        if (index == 0) {//首字符
            //源字符串是否包含 搜索字符串
            //判断searchString是不是sourceString 的前缀
            if([sourceString hasPrefix:searchString]){
                [_resultArray addObject:sourceString];
            }
            
        }else{//包含字符
            //一个字符串在另一个字符串中的长度和位置，来判断是否被包含
            NSRange range = [sourceString rangeOfString:searchString];
            //NSNotFound:是一个很大的数,可以泛指小字符串不在大字符串中
            //判断位置是否找到：123456：34
            if (range.location != NSNotFound) {
                
                [_resultArray addObject:sourceString];
            }
        }
    }
    
    return YES;
}

//当搜索条件改变时，会调用
//searchOption:被选中条件按钮的索引
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSLog(@"2_____%s__",__FUNCTION__);
    
    NSString* searchString = controller.searchBar.text;
    
    
    //每次搜索之前，清空结果表
    [_resultArray removeAllObjects];
    
    //遍历数组：源数组，目的：查找符合条件的搜索字符
    for (int i = 0; i<_dataArray.count; i++) {
        //源字符串
        NSString* sourceString = _dataArray[i];
        
        if (searchOption == 0) {//首字符
            //源字符串是否包含 搜索字符串
            //判断searchString是不是sourceString 的前缀
            if([sourceString hasPrefix:searchString]){
                [_resultArray addObject:sourceString];
            }
            
        }else{//包含字符
            //一个字符串在另一个字符串中的长度和位置，来判断是否被包含
            NSRange range = [sourceString rangeOfString:searchString];
            //NSNotFound:是一个很大的数
            //判断位置是否找到：123456：34
            if (range.location != NSNotFound) {
                
                [_resultArray addObject:sourceString];
            }
        }
    }

    return YES;
}


#pragma mark --- tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableView == tableView) {
       return _dataArray.count;
    }else{
        return _resultArray.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseID = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    if (_tableView == tableView) {
        cell.textLabel.text = _dataArray[indexPath.row];
    }else{
        cell.textLabel.text = _resultArray[indexPath.row];
    }
    
    return cell;
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end






