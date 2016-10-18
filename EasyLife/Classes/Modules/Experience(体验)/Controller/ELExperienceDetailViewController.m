//
//  ELExperienceDetailViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/10/11.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELExperienceDetailViewController.h"
#import "UIImageView+WebCache.h"

static CGFloat DetailViewController_TopImageView_Height = 225;

@interface ELExperienceDetailViewController () <UIWebViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIView *customNav;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, assign) BOOL showBlackImage;
@property (nonatomic, assign) BOOL isHtmlFinishLoad;
@property (nonatomic, assign) BOOL isAddBottomViews;
@property (nonatomic, assign) CGFloat lastOffsetY;
@end

@implementation ELExperienceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setCustomNavigationItem];
    [self setBottomView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.topImageView];
}

- (void)setBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, AppHeight - 49, AppWidth, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *btn = [UIButton new];
    [btn setBackgroundImage:[UIImage imageNamed:@"registration_1"] forState:UIControlStateNormal];
    btn.frame = CGRectMake((AppWidth - 158) * 0.5, (49 - 36) * 0.5, 158, 36);
    [btn setTitle:@"报 名" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
}

- (void)setCustomNavigationItem {
    [self.view addSubview:self.customNav];
    
    _backBtn = [UIButton new];
    [self setButton:_backBtn frame:CGRectMake(-7, 20, 44, 44) imageName:@"back_0" highlightImage:@"back_2" action:@selector(backBtnClick)];
    [self.view addSubview:_backBtn];
    _likeBtn = [UIButton new];
    [self setButton:_likeBtn frame:CGRectMake(AppWidth - 105, 20, 44, 44) imageName:@"collect_0" highlightImage:@"collect_0" action:@selector(lickBtnClick)];
    [self.view addSubview:_likeBtn];
    // 分享按钮
    _shareBtn = [UIButton new];
    [self setButton:_shareBtn frame:CGRectMake(AppWidth - 54, 20, 44, 44) imageName:@"share_0" highlightImage:@"share_2" action:@selector(shareBtnClick)];
    [self.view addSubview:_shareBtn];
}

- (void)setButton:(UIButton *)btn frame:(CGRect)frame imageName:(NSString *)image highlightImage:(NSString *)highlightImage action:(SEL)action {
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - lazy
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        CGFloat contentH = DetailViewController_TopImageView_Height - 20;
        _webView.scrollView.contentInset = UIEdgeInsetsMake(contentH, 0, 49, 0);
//        [_webView.scrollView setContentOffset:CGPointMake(0, -contentH)];
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.delegate = self;
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.contentSize = CGSizeMake(AppWidth, 0);
        _webView.paginationBreakingMode = UIWebPaginationBreakingModeColumn;
        
    }
    return _webView;
}

- (UIView *)customNav {
    if (_customNav == nil) {
        _customNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, 64)];
        _customNav.backgroundColor = [UIColor whiteColor];
        _customNav.alpha = 0.;
    }
    return _customNav;
}

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, DetailViewController_TopImageView_Height)];
        _topImageView.image = [UIImage imageNamed:@"quesheng"];
        _topImageView.contentMode = UIViewContentModeScaleToFill;
        _topImageView.clipsToBounds = YES;
    }
    
    return _topImageView;
}

- (void)setModel:(EventModel *)model {
    _model = model;
    
    self.webView.hidden = YES;
    NSString *imgStr = [self.model.imgs lastObject];
    if (imgStr) {
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"quesheng"]];
    }
    
    // 设置分享model
    
    NSString *htmlStr = self.model.mobileURL;
    if (htmlStr) {
        [self.webView loadHTMLString:htmlStr baseURL:nil];
        [self.webView.scrollView setContentOffset:CGPointMake(0, -DetailViewController_TopImageView_Height + 20)];
        self.webView.hidden = NO;
    }
    
    // 添加webView底部的view,添加在webView的scrollView中
    
    
}

#pragma mark - 事件
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lickBtnClick {
    
}

- (void)shareBtnClick {
    
}

- (void)btnClick {
//    ELSignUpViewController *suVC = [[ELSignUpViewController alloc] init];
//    suVC.topTitle = model.title;
//    [self.navigationController pushViewController:suVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat scrollShowNavH = (DetailViewController_TopImageView_Height - 64);
    self.customNav.alpha = 1 + (offsetY + 64) / scrollShowNavH;
    
    if (offsetY >= -64 && _showBlackImage == NO) {
        [self.backBtn setImage:[UIImage imageNamed:@"back_1"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"collect_1"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"share_1"] forState:UIControlStateNormal];
        self.showBlackImage = YES;
    } else if (offsetY < -64 && _showBlackImage == YES) {
        [self.backBtn setImage:[UIImage imageNamed:@"back_0"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"collect_0"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"share_0"] forState:UIControlStateNormal];
        self.showBlackImage = NO;
    }
    
    // 顶部imageView的跟随动画
    if (offsetY <= -DetailViewController_TopImageView_Height) {
        self.topImageView.top = 0;
        self.topImageView.height = -offsetY;
        self.topImageView.width = AppWidth - offsetY - DetailViewController_TopImageView_Height;
        self.topImageView.left = (0 + DetailViewController_TopImageView_Height + offsetY) * 0.5;
    } else {
        self.topImageView.top = -offsetY - DetailViewController_TopImageView_Height;
    }
    
    // 记录scrollView最后的偏移量,用于切换scrollView时同步俩个scrollView的偏移值
    self.lastOffsetY = offsetY;
    CGSize size = self.webView.scrollView.contentSize;
    NSLog(@"web scroll content size (%f, %f)", size.width, size.height);
    // al:在这个方法里面添加bottom views, 而且要在 html加载完成之后再添加bottom views; 同事修改scrollView contentsize
    if (self.isHtmlFinishLoad && !self.isAddBottomViews) {
        self.isAddBottomViews = YES;
        CGFloat contentSizeH = self.webView.scrollView.contentSize.height;
        UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, contentSizeH, AppWidth - 30, 20)];
        [testBtn setTitle:@"我在webView.scrollView上" forState:UIControlStateNormal];
        testBtn.backgroundColor = [UIColor orangeColor];
        [self.webView.scrollView addSubview:testBtn];
        
        self.webView.scrollView.contentSize = CGSizeMake(AppWidth, contentSizeH + 20);
    }
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.isHtmlFinishLoad = YES;
}

@end
