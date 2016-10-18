//
//  ELThemeViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/10/8.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELThemeViewController.h"
#import "ELEveryDayModel.h"
#import "DetailCell.h"
#import "ELEventViewController.h"

static NSString *ELDetailCellID = @"DetailCell";

@interface ELThemeViewController () <UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *moreTableView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *modalBtn;

@property (nonatomic, strong) ELDetailModel *moreModel;
@end

@implementation ELThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadMore];
    [self addModalBtn];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.moreTableView];
    [self.backView addSubview:self.webView];
    self.navigationItem.rightBarButtonItem = [self getCustomItem];
}

- (void)loadMore {
    __weak typeof(self) weakSelf = self;
    [ELDetailModel loadMore:^(ELDetailModel *detailModel, NSError *error) {
        if (error != nil) {
            //提示错误
            return;
        }
        weakSelf.moreModel = detailModel;
        [weakSelf.moreTableView reloadData];
    }];
}

- (void)addModalBtn {
    CGFloat modalWH = 64;
    self.modalBtn = [UIButton new];
    self.modalBtn.frame = CGRectMake(10, AppHeight - modalWH - 10, modalWH, modalWH);
    [self.modalBtn setImage:[UIImage imageNamed:@"themelist"] forState:UIControlStateNormal];
    [self.modalBtn setImage:[UIImage imageNamed:@"themeweb"] forState:UIControlStateSelected];
    [self.modalBtn addTarget:self action:@selector(modalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.modalBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UITableView *)moreTableView {
    if (_moreTableView == nil) {
        _moreTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _moreTableView.rowHeight = 220;
//        _moreTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _moreTableView.delegate = self;
        _moreTableView.dataSource = self;
        [_moreTableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    }
    return _moreTableView;
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _webView.top = 64;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIBarButtonItem *)getCustomItem {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"share_1"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"share_2"] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 50, 44);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
}

#pragma mark - 事件
- (void)shareClick {
    
}

- (void)modalBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [UIView transitionFromView:self.webView toView:self.moreTableView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    } else {
        [UIView transitionFromView:self.moreTableView toView:self.webView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
    }
}

#pragma mark - setters
- (void)setThemeModel:(ThemeModel *)themeModel {
    _themeModel = themeModel;
    
    if ([themeModel.hasweb integerValue] == 1) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:themeModel.themeurl]]];
        // 设置shareView的model
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moreModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    cell.model = self.moreModel.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EventModel *model = self.moreModel.list[indexPath.row];
    ELEventViewController *eventVC = [[ELEventViewController alloc] init];
    eventVC.eventModel = model;
    [self.navigationController pushViewController:eventVC animated:YES];
}

@end
