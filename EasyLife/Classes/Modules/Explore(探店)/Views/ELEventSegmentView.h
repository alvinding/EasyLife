//
//  ELEventSegmentView.h
//  EasyLife
//
//  Created by dingchuan on 16/10/9.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELEventSegmentView;
@protocol ELEventSegmentViewDelegate <NSObject>

-(void)segmentView:(ELEventSegmentView *)segmentView didSelectAtIndex:(NSInteger)index;

@end

@interface ELEventSegmentView : UIView
@property (nonatomic, weak) id<ELEventSegmentViewDelegate> delegate;
@end
