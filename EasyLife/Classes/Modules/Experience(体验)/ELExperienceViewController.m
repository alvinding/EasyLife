//
//  ELExperienceViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/9/22.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELExperienceViewController.h"
#import "ELMainTableView.h"
#import "ELExperienceCell.h"
#import "ELExperienceModel.h"
#import "ELExperienceDetailViewController.h"

@interface ELExperienceViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) ELMainTableView *tableView;
@property (nonatomic, strong) ELExperienceModel *expModel;
@end

@implementation ELExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"体验";
    [self.view addSubview:self.tableView];
    [self loadDatas];
}

#pragma mark - lazy
-(ELMainTableView *)tableView {
    if (!_tableView) {
        _tableView = [[ELMainTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain dataSource:self delegate:self];
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64 + 49, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"ELExperienceCell" bundle:nil] forCellReuseIdentifier:@"ELExperienceCell"];
    }
    
    return _tableView;
}

- (void)loadDatas {
    __weak typeof(self) weakSelf = self;
    [ELExperienceModel loadExperienceModel:^(ELExperienceModel *data, NSError *error) {
        if (error) {
            return;
        }
        weakSelf.expModel = data;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.expModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELExperienceCell"];
    cell.model = self.expModel.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ELExperienceDetailViewController *detailVC = [[ELExperienceDetailViewController alloc] init];
    detailVC.model = self.expModel.list[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
