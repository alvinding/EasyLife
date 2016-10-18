//
//  ELExploreViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/9/22.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELExploreViewController.h"
#import "ELDoubleSegmentView.h"
#import "ELRefreshHeader.h"
#import "ELEveryDayModel.h"
#import "ELEventCell.h"
#import "ELThemeCell.h"
#import "ELThemeViewController.h"
#import "ELEventViewController.h"
#import "ELNearbyViewController.h"

static const CGFloat EL_RefreshImage_Height = 40;
static const CGFloat EL_RefreshImage_Width = 35;

@interface ELExploreViewController () <ELDoubleSegmentViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ELDoubleSegmentView *doubleSegmentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *dayTableView;
@property (nonatomic, strong) UITableView *albumTableView;

@property (nonatomic, strong) NSArray *daysData;
@property (nonatomic, strong) NSArray *themesData;
@end

@implementation ELExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    [self setScrollView];
    [self setDayTableView];
    [self setAlbumTableView];
    
    [self.dayTableView.header beginRefreshing];
    [self.albumTableView.header beginRefreshing];
}

- (void)setNav {
    self.doubleSegmentView = [[ELDoubleSegmentView alloc] init];
    [self.doubleSegmentView setLeftText:@"美天" rightText:@"美辑"];
    self.doubleSegmentView.frame = CGRectMake(0, 0, 120, 44);
    self.doubleSegmentView.delegate = self;
    self.navigationItem.titleView = self.doubleSegmentView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"附近" style:UIBarButtonItemStyleDone target:self action:@selector(nearClick)];
}

- (void)setScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, AppWidth, AppHeight - 49 - 64)];
    self.scrollView.contentSize = CGSizeMake(AppWidth * 2, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

- (void)setDayTableView {
    self.dayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, self.scrollView.height) style:UITableViewStylePlain];
    self.dayTableView.backgroundColor = [UIColor redColor];
    self.dayTableView.delegate = self;
    self.dayTableView.dataSource = self;
    [self.scrollView addSubview:self.dayTableView];
    [self setTableViewHeader:self.dayTableView freshTarget:self freshAction:@selector(pullLoadData) imageFrame:CGRectMake((AppWidth - EL_RefreshImage_Width) * 0.5, 10, EL_RefreshImage_Width, EL_RefreshImage_Height)];
}

- (void)setAlbumTableView {
    self.albumTableView = [[UITableView alloc] initWithFrame:CGRectMake(AppWidth, 0, AppWidth, self.scrollView.height) style:UITableViewStylePlain];
    self.albumTableView.delegate = self;
    self.albumTableView.dataSource = self;
    [self.scrollView addSubview:self.albumTableView];
    [self setTableViewHeader:self.albumTableView freshTarget:self freshAction:@selector(pullLoadAlbumData) imageFrame:CGRectMake((AppWidth - EL_RefreshImage_Width) * 0.5, 10, EL_RefreshImage_Width, EL_RefreshImage_Height)];
}

- (void)setTableViewHeader:(UITableView *)tableView freshTarget:(id)target freshAction:(SEL)action imageFrame:(CGRect)frame {
    ELRefreshHeader *header = [ELRefreshHeader headerWithRefreshingTarget:target refreshingAction:action];
    header.gifView.frame = frame;
    tableView.header = header;
}

- (void)pullLoadData {
    __weak typeof(self) weakSelf = self;
    [ELEveryDayModel loadEventsData:^(NSArray *data) {
        NSLog(@"success load data");
        weakSelf.daysData = data;
        [weakSelf.dayTableView reloadData];
        [weakSelf.dayTableView.header endRefreshing];
    }];
}

- (void)pullLoadAlbumData {
    __weak typeof(self) weakSelf = self;
    [ELEveryDayModel loadThemesData:^(NSArray *data) {
        NSLog(@"success load themes data");
        weakSelf.themesData = data;
        [weakSelf.albumTableView reloadData];
        [weakSelf.albumTableView.header endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate, datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.albumTableView) {
        return self.themesData.count;
    } else {
        EDay *eDay = self.daysData[section];
        if ([eDay.themes lastObject]) {
            return 2;
        }
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.albumTableView) {
        return 240;
    } else {
        if (indexPath.row == 1) {
            return 220;
        } else {
            return 253;
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.albumTableView) {
        return 1;
    } else {
        return self.daysData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (tableView == self.albumTableView) {
        ThemeModel *themeModel = self.themesData[indexPath.row];
        cell = [ELThemeCell themeCellWithTableView:tableView];
        ((ELThemeCell *)cell).model = themeModel;
    } else {
        EDay *eModel = self.daysData[indexPath.section];
        if (indexPath.row == 1) {
            cell = [ELThemeCell themeCellWithTableView:tableView];
            ((ELThemeCell *)cell).model = (ThemeModel *)[eModel.themes lastObject];
        } else {
            cell = [ELEventCell eventCellWithTableView:tableView];
            EventModel *eventM = [eModel.events lastObject];
            ((ELEventCell *)cell).model = eventM;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.albumTableView) {
        ThemeModel *themeModel = self.themesData[indexPath.row];
        ELThemeViewController *themeVC = [[ELThemeViewController alloc] init];
        themeVC.themeModel = themeModel;
        [self.navigationController pushViewController:themeVC animated:YES];
    } else {
        EDay *eDayModel = self.daysData[indexPath.section];
        if (indexPath.row == 1) {
            ELThemeViewController *themeVC = [[ELThemeViewController alloc] init];
            themeVC.themeModel = [eDayModel.themes lastObject];
            [self.navigationController pushViewController:themeVC animated:YES];
        } else {
            ELEventViewController *eventVC = [[ELEventViewController alloc] init];
            eventVC.eventModel = eDayModel.events[indexPath.row];
            [self.navigationController pushViewController:eventVC animated:YES];
        }
    }
}

#pragma mark - ELDoubleSegmentViewDelegate
- (void)doubleSegmentView:(ELDoubleSegmentView *)segmentView didClickBtn:(UIButton *)btn atIndex:(NSInteger)index {
    NSLog(@"index---%zd", index);
    
    [self.scrollView setContentOffset:CGPointMake(AppWidth * index, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSInteger scrollIndex = scrollView.contentOffset.x / AppWidth;
        [self.doubleSegmentView clickBtnAtIndex:scrollIndex];
    }
}

#pragma mark - event
- (void)nearClick {
    ELNearbyViewController *nearbyVC = [[ELNearbyViewController alloc] init];
    [self.navigationController pushViewController:nearbyVC animated:YES];
}

@end
