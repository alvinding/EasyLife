//
//  DetailCell.h
//  EasyLife
//
//  Created by dingchuan on 16/10/9.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELEveryDayModel.h"

@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (nonatomic, strong) EventModel *model;
@end
