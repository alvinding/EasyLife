//
//  UserInfoManager.m
//  EasyLife
//
//  Created by dingchuan on 16/10/9.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager
+(instancetype)sharedUserInfoManager {
    static UserInfoManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserInfoManager alloc] init];
        
    });
    return sharedInstance;
}
@end
