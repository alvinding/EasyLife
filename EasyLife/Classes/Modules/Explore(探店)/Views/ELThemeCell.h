//
//  ELThemeCell.h
//  EasyLife
//
//  Created by dingchuan on 16/9/23.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELEveryDayModel.h"

@interface ELThemeCell : UITableViewCell
@property (nonatomic, strong) ThemeModel *model;

+ (instancetype)themeCellWithTableView:(UITableView *)tableView; 
@end
