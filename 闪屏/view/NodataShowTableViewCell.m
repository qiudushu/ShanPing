//
//  NodataShowTableViewCell.m
//  闪屏
//
//  Created by 邱读书 on 2018/11/21.
//  Copyright © 2018 邱读书. All rights reserved.
//

#import "NodataShowTableViewCell.h"
#import <Masonry.h>

@implementation NodataShowTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        UIView *showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:showView];
        [showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(20);
            make.right.bottom.mas_equalTo(-20);
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
