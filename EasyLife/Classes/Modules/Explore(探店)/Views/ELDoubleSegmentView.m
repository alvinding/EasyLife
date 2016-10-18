//
//  ELDoubleSegmentView.m
//  EasyLife
//
//  Created by dingchuan on 16/9/22.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELDoubleSegmentView.h"

@interface ELDoubleSegmentView ()
@property (nonatomic, strong) NoHighlightButton *leftTextButton;
@property (nonatomic, strong) NoHighlightButton *rightTextButton;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation ELDoubleSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.leftTextButton = [NoHighlightButton new];
        
        self.rightTextButton = [NoHighlightButton new];
        [self setButton:self.leftTextButton tag:101];
        [self setButton:self.rightTextButton tag:102];
        [self setBottomLine];
        
        [self titleBtnClick:self.leftTextButton];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = self.width * 0.5;
    self.leftTextButton.frame = CGRectMake(0, 0, btnW, self.height);
    self.rightTextButton.frame = CGRectMake(btnW, 0, btnW, self.height);
    self.bottomLineView.frame = CGRectMake(0, self.height - 2, btnW, 2);
}

- (void)setButton:(UIButton *)btn tag:(NSInteger)tag {
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitleColor:ELColor(100, 100, 100) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.tag = tag;
    [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)setBottomLine {
    self.bottomLineView = [UIView new];
    self.bottomLineView.backgroundColor = ELColor(60, 60, 60);
    [self addSubview:self.bottomLineView];
}

- (void)titleBtnClick:(UIButton *)btn {
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    [self bottomViewScrollTo:btn.tag - 101];
    
    if ([self.delegate respondsToSelector:@selector(doubleSegmentView:didClickBtn:atIndex:)]) {
        [self.delegate doubleSegmentView:self didClickBtn:btn atIndex:btn.tag - 101];
    }
}

- (void)bottomViewScrollTo:(NSInteger)index {
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLineView.left = index * self.bottomLineView.width;
    }];
}

#pragma mark - 提供给外部的方法
/**
 *  设置button的title
 *
 *  @param leftText  <#leftText description#>
 *  @param rightText <#rightText description#>
 */
- (void)setLeftText:(NSString *)leftText rightText:(NSString *)rightText {
    [self.leftTextButton setTitle:leftText forState:UIControlStateNormal];
    [self.rightTextButton setTitle:rightText forState:UIControlStateNormal];
}

/**
 *  主要用于scrollView左右滑动时，button选中状态的切换
 *
 *  @param index <#index description#>
 */
- (void)clickBtnAtIndex:(NSInteger)index {
    NoHighlightButton *btn = (NoHighlightButton *)[self viewWithTag:index + 101];
    [self titleBtnClick:btn];
}

@end


@implementation NoHighlightButton

- (void)setHighlighted:(BOOL)highlighted {
    super.highlighted = NO;
}

@end