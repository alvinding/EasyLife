//
//  ELLongPressGestureRecognizer.m
//  EasyLife
//
//  Created by dingchuan on 16/10/13.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELLongPressGestureRecognizer.h"

@implementation ELLongPressGestureRecognizer
//- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer {
//    
//}
- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer {
    return NO;
}
@end
