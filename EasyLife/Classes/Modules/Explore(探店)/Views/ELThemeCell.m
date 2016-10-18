//
//  ELThemeCell.m
//  EasyLife
//
//  Created by dingchuan on 16/9/23.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELThemeCell.h"
#import "UIImageView+WebCache.h"

@interface ELThemeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@end

@implementation ELThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.shadowOffset = CGSizeMake(-1, 1);
    self.titleLabel.shadowColor = ELColorA(20, 20, 20, 0.1);
    self.subTitleLabel.shadowOffset = CGSizeMake(-1, 1);
    self.subTitleLabel.shadowColor = ELColorA(20, 20, 20, 0.1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ThemeModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.keywords;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"quesheng"]];
}

+ (instancetype)themeCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"themeCell";
    ELThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = (ELThemeCell *)[[[NSBundle mainBundle] loadNibNamed:@"ELThemeCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
