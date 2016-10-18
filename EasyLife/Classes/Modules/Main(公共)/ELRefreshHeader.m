//
//  ELRefreshHeader.m
//  EasyLife
//
//  Created by alvin on 16/9/22.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELRefreshHeader.h"

@implementation ELRefreshHeader

- (void)prepare {
    [super prepare];
    
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
    
    NSMutableArray *idleImages = [NSMutableArray array];
    [idleImages addObject:[UIImage imageNamed:@"wnx00"]];
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    NSMutableArray *pullingImages = [NSMutableArray array];
    [idleImages addObject:[UIImage imageNamed:@"wnx00"]];
    [self setImages:pullingImages forState:MJRefreshStatePulling];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i=0; i < 93; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"wnx%02d", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
