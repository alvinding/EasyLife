//
//  ELExperienceCell.m
//  EasyLife
//
//  Created by dingchuan on 16/10/10.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELExperienceCell.h"
#import "UIImageView+WebCache.h"

@implementation ELExperienceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(EventModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    
    if (model.imgs.count > 0) {
        NSString *imgStr = [model.imgs firstObject];
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"quesheng"]];
    }
}

@end
