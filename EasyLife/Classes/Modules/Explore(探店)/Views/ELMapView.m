//
//  ELMapView.m
//  EasyLife
//
//  Created by dingchuan on 16/10/11.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELMapView.h"
#import "ELMapCollectionCell.h"
#import "ELEventViewController.h"

static NSString *pointReuseIdentifier = @"pointReuseIdentifier";

@interface ELMapView () <MAMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *flagsArray;
@property (nonatomic, strong) MAAnnotationView *lastMAAnnotationView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *myLocationBtn;
@end

@implementation ELMapView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.showsScale = NO;
        self.showsCompass = NO;
        self.showsUserLocation = YES;
        self.logoCenter = CGPointMake(AppWidth - self.logoSize.width + 20, self.logoCenter.y);
        self.zoomLevel = 12;
        [self setCenterCoordinate:CLLocationCoordinate2DMake(22.5633480000, 114.0795910000) animated:YES];
        self.mapType = MAMapTypeStandard;
        
        [self addSubview:self.myLocationBtn];
        [self addSubview:self.collectionView];
    }
    
    return self;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat height = 105;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        CGFloat margin = 20;
        CGFloat itemW = AppWidth - 35 - 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(itemW, height);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, AppHeight - height - 10, AppWidth - 35, height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.clipsToBounds = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"ELMapCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ELMapCollectionCell"];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    
    return _collectionView;
}

- (UIButton *)myLocationBtn {
    if (_myLocationBtn == nil) {
        CGFloat btnWH = 57;
        _myLocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, AppHeight - 120 - btnWH, btnWH, btnWH)];
        [_myLocationBtn setBackgroundImage:[UIImage imageNamed:@"dingwei_1"] forState:UIControlStateNormal];
        [_myLocationBtn setBackgroundImage:[UIImage imageNamed:@"dingwei_2"] forState:UIControlStateHighlighted];
        [_myLocationBtn addTarget:self action:@selector(myLocationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _myLocationBtn;
}

- (void)setModel:(ELDetailModel *)model {
    _model = model;
    self.flagsArray = [NSMutableArray array];
    [self.collectionView reloadData];
    
    for (int i = 0; i < model.list.count; i++) {
        EventModel *eventModel = model.list[i];
        // TODO: NSString to 经纬度
        CLLocationCoordinate2D position2D = [self coordinate2DFromString:eventModel.position];
        MAPointAnnotation *po = [[MAPointAnnotation alloc] init];
        po.coordinate = position2D;
        [self.flagsArray addObject:po];
        [self addAnnotation:po];
        
        if (i == 0) {
            [self selectAnnotation:po animated:YES];
        }
    }
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ELMapCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ELMapCollectionCell" forIndexPath:indexPath];
    cell.model = self.model.list[indexPath.row];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentIndex = self.collectionView.contentOffset.x / self.collectionView.size.width + 0.5;
    MAPointAnnotation *anotation = self.flagsArray[currentIndex];
    [self selectAnnotation:anotation animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ELEventViewController *eventVC = [[ELEventViewController alloc] init];
    eventVC.eventModel = self.model.list[indexPath.row];
    if (self.collectionCellDidClickBlock) {
        self.collectionCellDidClickBlock(eventVC);
    }
}

#pragma mark - MAMapViewDelegate
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    // 显示大头针view , 同tableView cell使用方法
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        MAPinAnnotationView *pinAnno = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIdentifier];
        if (pinAnno == nil) {
            pinAnno = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIdentifier];
        }
        
        pinAnno.image = [UIImage imageNamed:@"zuobiao1"];
        pinAnno.center = CGPointMake(0, -(pinAnno.image.size.height * 0.5));
        return pinAnno;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    // 改变选中大头针图片；改变对应collection view index
    self.lastMAAnnotationView.image = [UIImage imageNamed:@"zuobiao1"];
    view.image = [UIImage imageNamed:@"zuobiao2"];
    self.lastMAAnnotationView = view;
    [self setCenterCoordinate:view.annotation.coordinate animated:YES];
    
    NSInteger currentIndex = [self indexOfAnnotationView:view];
    [self.collectionView setContentOffset:CGPointMake(currentIndex * self.collectionView.width, 0) animated:YES];
}

#pragma mark - event
- (void)myLocationBtnClick {
    // TODO:
}

#pragma mark - private
- (CLLocationCoordinate2D)coordinate2DFromString:(NSString *)positionStr {
    NSArray *strArray = [positionStr componentsSeparatedByString:@","];
    if (strArray.count != 2) {
        return kCLLocationCoordinate2DInvalid;
    }
    
    double latitude = [strArray[1] doubleValue];
    double longitude = [strArray[0] doubleValue];
    return CLLocationCoordinate2DMake(latitude, longitude);
}

- (NSInteger)indexOfAnnotationView:(MAAnnotationView *)view {
    for (int i = 0; i < self.flagsArray.count; i++) {
        MAPointAnnotation *po = self.flagsArray[i];
        if ([self viewForAnnotation:po] == view) {
            return i;
        }
    }
    
    return 0;
}
@end
