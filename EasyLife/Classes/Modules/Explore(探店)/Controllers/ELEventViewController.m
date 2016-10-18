//
//  ELEventViewController.m
//  EasyLife
//
//  Created by dingchuan on 16/10/9.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELEventViewController.h"
#import "ELEventSegmentView.h"
#import "UIImageView+WebCache.h"

#import "ELLongPressGestureRecognizer.h"

static CGFloat DetailViewController_TopImageView_Height = 225;
static CGFloat EventViewController_ShopView_Height = 45;

@interface ELEventViewController () <ELEventSegmentViewDelegate, UIScrollViewDelegate, UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIScrollView *detailSV;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) ELEventSegmentView *segmentView;
@property (nonatomic, strong) UIView *customNav;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, assign) BOOL showBlackImage;
@property (nonatomic, assign) CGFloat lastOffsetY;
@end

@implementation ELEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setCustomNavigationItem];
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
    [self.view addSubview:self.detailSV];
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.segmentView];
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

- (void)setEventModel:(EventModel *)eventModel {
    _eventModel = eventModel;
    
    self.detailSV.contentSize = CGSizeMake(AppWidth, AppHeight - DetailViewController_TopImageView_Height);
    
    NSString *imageStr = [eventModel.imgs lastObject];
    if (imageStr) {
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"quesheng"]];
    }
    
    // TODO: 从新计算宽度、添加title等
    NSString *htmlStr = eventModel.mobileURL;
    [self.webView loadHTMLString:htmlStr baseURL:nil];
    self.webView.hidden = NO;
}

#pragma mark - lazy
- (UIScrollView *)detailSV {
    if (_detailSV == nil) {
        _detailSV = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _detailSV.contentInset = UIEdgeInsetsMake(DetailViewController_TopImageView_Height + EventViewController_ShopView_Height, 0, 0, 0);
        _detailSV.showsHorizontalScrollIndicator = NO;
        _detailSV.alwaysBounceVertical = YES;
        _detailSV.hidden = YES;
        _detailSV.delegate = self;
        [_detailSV setContentOffset:CGPointMake(0, -(DetailViewController_TopImageView_Height + EventViewController_ShopView_Height))];
    }
    return _detailSV;
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

- (ELEventSegmentView *)segmentView {
    if (_segmentView == nil) {
        _segmentView = [[ELEventSegmentView alloc] initWithFrame:CGRectMake(0, DetailViewController_TopImageView_Height, AppWidth, EventViewController_ShopView_Height)];
        _segmentView.delegate = self;
    }
    
    return _segmentView;
}

- (UIView *)customNav {
    if (_customNav == nil) {
        _customNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, 64)];
        _customNav.backgroundColor = [UIColor whiteColor];
        _customNav.alpha = 0.;
    }
    return _customNav;
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        CGFloat topImageShopViewHeight = DetailViewController_TopImageView_Height - 20 + EventViewController_ShopView_Height;
        _webView.scrollView.contentInset = UIEdgeInsetsMake(topImageShopViewHeight, 0, 0, 0);
        [_webView.scrollView setContentOffset:CGPointMake(0, -topImageShopViewHeight)];
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.delegate = self;
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.paginationBreakingMode = UIWebPaginationBreakingModeColumn;
        
        ELLongPressGestureRecognizer *longPress = [[ELLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [_webView addGestureRecognizer:longPress];
    }
    return _webView;
}

#pragma mark - 事件
- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lickBtnClick {
    
}

- (void)shareBtnClick {
    
}

- (void)handleLongPress:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.webView];
        NSLog(@"x: %f, y: %f", point.x, point.y);
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat scrollShowNavH = (DetailViewController_TopImageView_Height - 64);
    self.customNav.alpha = 1 + (offsetY + 64 + EventViewController_ShopView_Height) / scrollShowNavH;
    
    if (offsetY + EventViewController_ShopView_Height >= -64 && _showBlackImage == NO) {
        [self.backBtn setImage:[UIImage imageNamed:@"back_1"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"collect_1"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"share_1"] forState:UIControlStateNormal];
        self.showBlackImage = YES;
    } else if (offsetY < -64 - EventViewController_ShopView_Height && _showBlackImage == YES) {
        [self.backBtn setImage:[UIImage imageNamed:@"back_0"] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"collect_0"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"share_0"] forState:UIControlStateNormal];
        self.showBlackImage = NO;
    }
    
    // 顶部imageView的跟随动画
    if (offsetY <= -DetailViewController_TopImageView_Height - EventViewController_ShopView_Height) {
        self.topImageView.top = 0;
        self.topImageView.height = -offsetY - EventViewController_ShopView_Height;
        self.topImageView.width = AppWidth - offsetY - DetailViewController_TopImageView_Height;
        self.topImageView.left = (0 + DetailViewController_TopImageView_Height + offsetY) * 0.5;
    } else {
        self.topImageView.top = -offsetY - DetailViewController_TopImageView_Height - EventViewController_ShopView_Height;
    }
    
    // 处理shopView
    if (offsetY >= -(EventViewController_ShopView_Height + 64)) {
        self.segmentView.frame = CGRectMake(0, 64, AppWidth, EventViewController_ShopView_Height);
    } else {
        self.segmentView.frame = CGRectMake(0, CGRectGetMaxY(self.topImageView.frame), AppWidth, EventViewController_ShopView_Height);
    }
    
    // 记录scrollView最后的偏移量,用于切换scrollView时同步俩个scrollView的偏移值
    self.lastOffsetY = offsetY;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

@end
