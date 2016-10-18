//
//  ELSearchViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/10/14.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELSearchViewController.h"

static CGFloat searchViewH = 40;

@interface ELSearchViewController () <UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *hotSearchs;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ELSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"搜索";
    self.hotSearchs = [NSMutableArray arrayWithObjects:@"北京", @"东四", @"南锣鼓巷", @"798", @"三里屯", @"维尼的小熊", nil];
    [self setupSearchView];
    [self setScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSearchView {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 70, AppWidth - 20 * 2, searchViewH)];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
}

- (void)setScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70 + searchViewH, AppWidth, AppHeight - searchViewH)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.alwaysBounceVertical = YES;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [scrollView addGestureRecognizer:tap];
    [self.view addSubview:scrollView];
    
    if (self.hotSearchs.count > 0) {
        UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
        hotLabel.font = [UIFont systemFontOfSize:16];
        hotLabel.text = @"热门搜索";
        [scrollView addSubview:hotLabel];
        
        CGFloat margin = 10;
        CGFloat btnH = 32;
        CGFloat btnY = CGRectGetMaxY(hotLabel.frame);
        CGFloat btnW = 0;
        CGFloat textMargin = 35;
        NSMutableArray *hotBtns = [NSMutableArray array];
        for (int i = 0; i < self.hotSearchs.count; i++) {
            UIButton *btn = [UIButton new];
            [btn setTitle:self.hotSearchs[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn.titleLabel sizeToFit];
            [btn setBackgroundImage:[UIImage imageNamed:@"populartags"] forState:UIControlStateNormal];
            btnW = btn.titleLabel.width + textMargin;
            [btn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (hotBtns.count > 0) {
                UIButton *lastBtn = [hotBtns lastObject];
                CGFloat freeW = AppWidth - CGRectGetMaxX(lastBtn.frame);
                if (freeW > btnW + 2 * margin) {
                    btn.frame = CGRectMake(CGRectGetMaxX(lastBtn.frame) + margin, btnY, btnW, btnH);
                } else {
                    btnY = CGRectGetMaxY(lastBtn.frame) + margin;
                    btn.frame = CGRectMake(margin, btnY, btnW, btnH);
                }
                [hotBtns addObject:btn];
                [scrollView addSubview:btn];
            } else {
                btn.frame = CGRectMake(margin, btnY, btnW, btnH);
                [hotBtns addObject:btn];
                [scrollView addSubview:btn];
            }
        }
    }
    
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 加载搜索结果， tableView展示
    NSLog(@"search submit");
}

#pragma mark - event 
- (void)searchBtnClick:(UIButton *)btn {
    
}

- (void)hideKeyboard {
    
}

@end
