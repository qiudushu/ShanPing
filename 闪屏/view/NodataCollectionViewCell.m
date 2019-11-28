//
//  NodataCollectionViewCell.m
//  闪屏
//
//  Created by 邱读书 on 2018/10/19.
//  Copyright © 2018 邱读书. All rights reserved.
//

#import "NodataCollectionViewCell.h"
#import <Masonry.h>

@interface NodataCollectionViewCell()

@end


@implementation NodataCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor greenColor];
        
        UIImageView *showIcon = [[UIImageView alloc]init];
        showIcon.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:showIcon];
        [showIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self.contentView).mas_offset(10);
            make.bottom.right.mas_equalTo(self.contentView).mas_offset(-10);
        }];
        
        //画圆角
        CGRect courseBgFrame = CGRectMake(0, 0, 240, 160);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:courseBgFrame
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight
                                                             cornerRadii:CGSizeMake(10.f, 10.f)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = courseBgFrame;
        maskLayer.path = maskPath.CGPath;
        showIcon.layer.mask = maskLayer;

        
    }
    return self;
}

@end
