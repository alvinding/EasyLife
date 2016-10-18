//
//  ELMainTableView.m
//  EasyLife
//
//  Created by dingchuan on 16/10/10.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELMainTableView.h"

@implementation ELMainTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = delegate;
        self.dataSource = dataSource;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
