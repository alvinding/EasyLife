//
//  ELEventSegmentView.m
//  EasyLife
//
//  Created by dingchuan on 16/10/9.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELEventSegmentView.h"

@interface ELEventSegmentView ()
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, strong) UIView *middleLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIView *blackLineView;
@property (nonatomic, strong) UIView *bottomBlackLineView;
@end

@implementation ELEventSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.blackLineView = [UIView new];
        self.blackLineView.alpha = 0.05;
        self.blackLineView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:self.blackLineView];
        
        self.bottomBlackLineView = [UIView new];
        self.bottomBlackLineView.alpha = 0.03;
        self.bottomBlackLineView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.bottomBlackLineView];
        
        _firstLabel = [UILabel new];
        [self setLabel:_firstLabel text:@"店 · 发现" tag:0 action:@selector(labelClick:)];
        _secondLabel = [UILabel new];
        [self setLabel:_secondLabel text:@"店 · 详情" tag:1 action:@selector(labelClick:)];
        
        _middleLineView = [UIView new];
        _middleLineView.backgroundColor = ELColorA(50, 50, 50, 0.1);
        [self addSubview:_middleLineView];
        
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = ELColorA(50, 50, 50, 1);
        [self addSubview:_bottomLineView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat labelW = self.width * 0.5;
    CGFloat labelH = self.height;
    _firstLabel.frame = CGRectMake(0, 0, labelW, labelH);
    _secondLabel.frame = CGRectMake(labelW, 0, labelW, labelH);
    
    CGFloat lineH = labelH * 0.5;
    _middleLineView.frame = CGRectMake(labelW - 0.5, (labelH - lineH) * 0.5, 1, lineH);
    
    CGFloat bottomLineW = labelW * 0.6;
    _bottomLineView.frame = CGRectMake((labelW - bottomLineW) * 0.5, labelH - 1.5, bottomLineW, 1.5);
    
    _blackLineView.frame = CGRectMake(0, 0, self.width, 1);
    _bottomBlackLineView.frame = CGRectMake(0, self.height, self.width, 1);
}

- (void)setLabel:(UILabel *)label text:(NSString *)text tag:(NSInteger)tag action:(SEL)action {
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    label.userInteractionEnabled = YES;
    label.tag = tag;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [label addGestureRecognizer:tap];
    [self addSubview:label];
}

- (void)labelClick:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(segmentView:didSelectAtIndex:)]) {
            [self.delegate segmentView:self didSelectAtIndex:index];
        }
    }
    
    CGFloat labelW = self.width * 0.5;
    CGFloat bottomLineW = labelW * 0.6;
    CGFloat bottomLineH = 1.5;
    CGFloat bottomLineX = index * labelW + (labelW - bottomLineW) * 0.5;
    CGFloat bottomLineY = self.height - bottomLineH;
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomLineView.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
    }];
}

@end
