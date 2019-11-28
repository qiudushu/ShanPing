//
//  ZYViewController.h
//  SearchBarTest
//
//  Created by Camille on 15/9/25.
//  Copyright (c) 2015年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;


@property(nonatomic,retain)NSMutableArray* dataArray;
@property(nonatomic,retain)NSMutableArray* resultArray;
@end
