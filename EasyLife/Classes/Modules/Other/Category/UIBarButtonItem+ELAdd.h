//
//  UIBarButtonItem+ELAdd.h
//  EasyLife
//
//  Created by dingchuan on 16/10/12.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ELAdd)
+ (instancetype)rightBarButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;
+ (instancetype)rightBarButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
