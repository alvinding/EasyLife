//
//  DetailCell.m
//  EasyLife
//
//  Created by dingchuan on 16/10/9.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+WebCache.h"

@implementation DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(EventModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.address;
    if ([model.imgs lastObject]) {
        NSString *imgStr = [model.imgs lastObject];
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"quesheng"]];
    }
}

@end
