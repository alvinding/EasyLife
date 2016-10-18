//
//  ELDoubleSegmentView.h
//  EasyLife
//
//  Created by dingchuan on 16/9/22.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELDoubleSegmentView;
@protocol ELDoubleSegmentViewDelegate <NSObject>

- (void)doubleSegmentView:(ELDoubleSegmentView *)segmentView didClickBtn:(UIButton *)btn atIndex:(NSInteger)index;

@end

@interface ELDoubleSegmentView : UIView
- (void)setLeftText:(NSString *)leftText rightText:(NSString *)rightText;
- (void)clickBtnAtIndex:(NSInteger)index;
@property (nonatomic, weak) id<ELDoubleSegmentViewDelegate> delegate;
@end

@interface NoHighlightButton : UIButton
@end