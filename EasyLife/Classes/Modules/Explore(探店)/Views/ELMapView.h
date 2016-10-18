//
//  ELMapView.h
//  EasyLife
//
//  Created by dingchuan on 16/10/11.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "ELEveryDayModel.h"

@interface ELMapView : MAMapView
@property (nonatomic, strong) ELDetailModel *model;

@property (nonatomic, copy) void (^collectionCellDidClickBlock)(UIViewController *vc);
@end
