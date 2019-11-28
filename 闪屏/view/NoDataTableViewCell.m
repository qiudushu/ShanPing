//
//  NoDataTableViewCell.m
//  闪屏
//
//  Created by 邱读书 on 2018/10/16.
//  Copyright © 2018 邱读书. All rights reserved.
//

#import "NoDataTableViewCell.h"
#import "Common.h"
#import <Masonry.h>
#import "NodataCollectionViewCell.h"
#import "showChildViewController.h"
#import "BaseTabbarViewController.h"

@interface NoDataTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) UIImageView *showIcon;
@end


@implementation NoDataTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //集合view
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.itemSize = CGSizeMake(260, 180);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        UICollectionView *mainView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        mainView.delegate = self;
        mainView.dataSource = self;
        mainView.backgroundColor = [UIColor orangeColor];
        [mainView registerClass:[NodataCollectionViewCell class] forCellWithReuseIdentifier:@"NodataCollectionViewCellID"];
        [self.contentView addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NodataCollectionViewCell *nodataViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NodataCollectionViewCellID" forIndexPath:indexPath];
    return nodataViewCell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    showChildViewController *mshowChildViewController = [[showChildViewController alloc]init];
    
    BaseTabbarViewController *tab = (BaseTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [tab.selectedViewController pushViewController:mshowChildViewController animated:YES];
}

@end
