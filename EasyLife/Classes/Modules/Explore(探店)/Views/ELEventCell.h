//
//  ELEventCell.h
//  EasyLife
//
//  Created by dingchuan on 16/9/23.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELEveryDayModel.h"

@interface ELEventCell : UITableViewCell
@property (nonatomic, strong) EventModel *model;

+ (instancetype)eventCellWithTableView:(UITableView *)tableView;
@end
