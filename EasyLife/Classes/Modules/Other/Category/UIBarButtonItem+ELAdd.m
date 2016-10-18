//
//  UIBarButtonItem+ELAdd.m
//  EasyLife
//
//  Created by dingchuan on 16/10/12.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "UIBarButtonItem+ELAdd.h"

@implementation UIBarButtonItem (ELAdd)
+(instancetype)rightBarButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.titleLabel.font = [UIFont systemFontOfSize:17];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    CGFloat btnW = AppWidth > 375.0 ? 50 : 44;
    btn.frame = CGRectMake(0, 0, 50, 44);
    
    return [[self alloc] initWithCustomView:btn];
}

+(instancetype)rightBarButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    btn.frame = CGRectMake(0, 0, 50, 44);
    
    return [[self alloc] initWithCustomView:btn];
}

@end
