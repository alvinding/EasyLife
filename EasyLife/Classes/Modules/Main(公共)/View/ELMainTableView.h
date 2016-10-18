//
//  ELMainTableView.h
//  EasyLife
//
//  Created by dingchuan on 16/10/10.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELMainTableView : UITableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(id<UITableViewDataSource>)dataSource delegate:(id<UITableViewDelegate>)delegate;
@end
