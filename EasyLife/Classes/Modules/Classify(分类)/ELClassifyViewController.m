//
//  ELClassifyViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/9/22.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELClassifyViewController.h"
#import "ELClassifyModel.h"
#import "ELClassifyCell.h"
#import "ELSearchViewController.h"

@interface ELClassifyViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ELClassifyModel *classifyModel;
@end

@implementation ELClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setCollectionView];
    [self loadDatas];
}

- (void)setupNav {
    self.navigationItem.title = @"分类";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightBarButtonItemWithImage:@"search_1" highlightImage:@"search_2" target:self action:@selector(searchBtnClick)];
    
}

- (void)setCollectionView {
    CGFloat margin = 10;
    CGFloat itemH = 80;
    CGFloat itemW = (AppWidth - 4 * margin) / 3 -2;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = margin;
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.headerReferenceSize = CGSizeMake(AppWidth, 50);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = true;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ELClassifyCell" bundle:nil] forCellWithReuseIdentifier:@"ELClassifyCell"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
}

- (void)loadDatas {
    __weak typeof(self) weakSelf = self;
    [ELClassifyModel loadClassifyModel:^(ELClassifyModel *data, NSError *error) {
        if (error) {
            return;
        }
        weakSelf.classifyModel = data;
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ((ELClassModel *)self.classifyModel.list[section]).tags.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.classifyModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ELClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ELClassifyCell" forIndexPath:indexPath];
    cell.model = ((ELClassModel *)self.classifyModel.list[indexPath.section]).tags[indexPath.row];
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//}

#pragma mark - event
- (void)searchBtnClick {
    ELSearchViewController *searchVC = [[ELSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
@end
