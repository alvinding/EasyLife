//
//  ELMapCollectionCell.m
//  EasyLife
//
//  Created by dingchuan on 16/10/12.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELMapCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface ELMapCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *disLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation ELMapCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

-(void)setModel:(EventModel *)model {
    _model = model;
    
    NSString *imgStr = [model.imgs firstObject];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"quesheng"]];
    self.titleLabel.text = model.title;
    self.addrLabel.text = model.address;
    self.disLabel.text = model.distanceForUser;
}

@end
