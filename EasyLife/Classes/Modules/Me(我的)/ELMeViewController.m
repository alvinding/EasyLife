//
//  ELMeViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/9/22.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELMeViewController.h"
#import "ELShakeViewController.h"

@interface ELMeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *meIcons;
@property (nonatomic, strong) NSMutableArray *meTitles;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ELMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.meIcons = [NSMutableArray arrayWithObjects:@"usercenter", @"orders", @"setting_like", @"feedback", @"recomment", nil];
    self.meTitles = [NSMutableArray arrayWithObjects:@"个人中心", @"我的订单", @"我的收藏", @"留言反馈", @"应用推荐", nil];
    [self setupTableView];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
    
    // 设置header view
    CGFloat iconImageViewH = 180;
    UIImageView *iconBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, iconImageViewH)];
    iconBgView.image = [UIImage imageNamed:@"quesheng"];
    self.tableView.tableHeaderView = iconBgView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        _tableView.sectionFooterHeight = 0.1;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return _tableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.meTitles.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"meCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:self.meIcons[indexPath.row]];
        cell.textLabel.text = self.meTitles[indexPath.row];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"yaoyiyao"];
        cell.textLabel.text = @"摇一摇 试试看";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    } else {
        if (indexPath.row == 0) {
            ELShakeViewController *shakeVC = [[ELShakeViewController alloc] init];
            [self.navigationController pushViewController:shakeVC animated:YES];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ELShakeViewController *shakeVC = [[ELShakeViewController alloc] init];
    [self.navigationController pushViewController:shakeVC animated:YES];
}
@end
