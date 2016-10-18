//
//  ELClassifyCell.m
//  EasyLife
//
//  Created by dingchuan on 16/10/13.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELClassifyCell.h"
#import "UIImageView+WebCache.h"

@interface ELClassifyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ELClassifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ELEveryClassModel *)model {
    _model = model;
    
    self.titleLabel.text = model.name;
    NSString *imgStr = model.img;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"quesheng"]];
}

@end
