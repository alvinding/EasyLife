//
//  ELEventCell.m
//  EasyLife
//
//  Created by dingchuan on 16/9/23.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELEventCell.h"
#import "UIImageView+WebCache.h"

@interface ELEventCell ()
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation ELEventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(EventModel *)model {
    _model = model;
    
    self.cellTitleLabel.text = model.feeltitle;
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.address;
    NSURL *imgUrl = [NSURL URLWithString:[model.imgs firstObject]];
    [self.bgImageView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"quesheng"]];
}

+ (instancetype)eventCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"eventCell";
    ELEventCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = (ELEventCell *)[[[NSBundle mainBundle] loadNibNamed:@"ELEventCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
