//
//  ELNearbyViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/10/12.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELNearbyViewController.h"
#import "ELMainTableView.h"
#import "ELEveryDayModel.h"
#import "DetailCell.h"
#import "ELMapView.h"

@interface ELNearbyViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) ELMainTableView *nearTableView;
@property (nonatomic, strong) ELDetailModel *detailModel;
@property (nonatomic, strong) ELMapView *mapView;
@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;
@end

@implementation ELNearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self pullLoadDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.nearTableView];
    [self.nearTableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
}

- (void)pullLoadDatas {
    __weak typeof(self) weakSelf = self;
    [ELDetailModel loadNearDatas:^(ELDetailModel *detailModel, NSError *error) {
        if (error != nil) {
            //提示错误
            return;
        }
        weakSelf.detailModel = detailModel;
        [weakSelf.nearTableView reloadData];
        // 设置mapView model, addMapView
        weakSelf.mapView.model = detailModel;
        [weakSelf addMapView];
    }];
}

- (void)addMapView {
    [self.backView insertSubview:self.mapView belowSubview:self.nearTableView];
}

#pragma mark - lazy
- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:self.view.bounds];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    
    return _backView;
}

- (ELMainTableView *)nearTableView {
    if (_nearTableView == nil) {
        _nearTableView = [[ELMainTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain dataSource:self delegate:self];
        _nearTableView.rowHeight = 220;
        [_nearTableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    }
    
    return _nearTableView;
}

- (ELMapView *)mapView {
    if (_mapView == nil) {
        _mapView = [[ELMapView alloc] initWithFrame:self.view.bounds];
        __weak typeof(self) weakSelf = self;
        _mapView.collectionCellDidClickBlock = ^(UIViewController *vc) {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _mapView;
}

- (UIBarButtonItem *)rightBtnItem {
    if (_rightBtnItem == nil) {
        _rightBtnItem = [UIBarButtonItem rightBarButtonItemWithImage:@"map_2-1" highlightImage:@"map_2" selectedImage:@"list_1" target:self action:@selector(rightBtnClick:)];
    }
    
    return _rightBtnItem;
}



#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.detailModel.list.count > 0) {
        self.navigationItem.rightBarButtonItem = self.rightBtnItem;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    return self.detailModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    cell.model = self.detailModel.list[indexPath.row];
    return cell;
}

#pragma mark - event
- (void)rightBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [UIView transitionFromView:self.nearTableView toView:self.mapView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    } else {
        [UIView transitionFromView:self.mapView toView:self.nearTableView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
    }
}

@end
