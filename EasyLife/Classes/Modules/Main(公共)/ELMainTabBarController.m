//
//  ELMainTabBarController.m
//  EasyLife
//
//  Created by dingchuan on 16/9/22.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELMainTabBarController.h"
#import "ELMainNavigationController.h"
#import "ELExploreViewController.h"
#import "ELExperienceViewController.h"
#import "ELClassifyViewController.h"
#import "ELMeViewController.h"

@implementation ELMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewControllers];
    [self setValue:[[ELMainTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setupChildViewControllers {
    [self addChildVC:[[ELExploreViewController alloc] init] title:@"探点" imageName:@"recommendation_1" selectedImageName:@"recommendation_2"];
    [self addChildVC:[[ELExperienceViewController alloc] init] title:@"体验" imageName:@"broadwood_1" selectedImageName:@"broadwood_2"];
    [self addChildVC:[[ELClassifyViewController alloc] init] title:@"分类" imageName:@"classification_1" selectedImageName:@"classification_2"];
    [self addChildVC:[[ELMeViewController alloc] init] title:@"我的" imageName:@"my_1" selectedImageName:@"my_2"];
}

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)image selectedImageName:(NSString *)selectedImage {
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    vc.view.backgroundColor = [UIColor whiteColor];
    ELMainNavigationController *nav = [[ELMainNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end

@implementation ELMainTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.translucent = NO;
        self.backgroundImage = [UIImage imageNamed:@"tabbar"];
    }
    
    return self;
}

@end
