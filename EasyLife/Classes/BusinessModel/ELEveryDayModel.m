//
//  ELEveryDayModel.m
//  EasyLife
//
//  Created by dingchuan on 16/9/23.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELEveryDayModel.h"

@implementation ThemeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"themeid"  : @"id"};
}
@end

@implementation GuessLikeModel

@end

@implementation EventModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"eventid"  : @"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"more" : [GuessLikeModel class]};
}
@end

@implementation EDay
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"themes" : [ThemeModel class],
             @"events" : [EventModel class]};
}
@end

@implementation EDays
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [EDay class] };
}
@end

@implementation EThemes
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ThemeModel class]};
}
@end

@implementation ELDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [EventModel class]};
}

+(void)loadDetails:(void (^)(ELDetailModel *, NSError *))completeBlock {
    ELDetailModel *detailModel = [[ELDetailModel alloc] init];
    [detailModel loadDatasFromFile:@"Details" isShowDis:NO completion:completeBlock];
}

+(void)loadMore:(void (^)(ELDetailModel *, NSError *))completeBlock {
    ELDetailModel *detailModel = [[ELDetailModel alloc] init];
    [detailModel loadDatasFromFile:@"More" isShowDis:NO completion:completeBlock];
}

+(void)loadNearDatas:(void (^)(ELDetailModel *, NSError *))completeBlock {
    ELDetailModel *detailModel = [[ELDetailModel alloc] init];
    [detailModel loadDatasFromFile:@"Nears" isShowDis:NO completion:completeBlock];
}

- (void)loadDatasFromFile:(NSString *)fileName isShowDis:(BOOL)isShowDis completion:(void (^)(ELDetailModel *data, NSError *error))completion {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        ELDetailModel *model = [ELDetailModel yy_modelWithJSON:dict];
        if (isShowDis) {
            // UserInfoManager设置用户位置信息
            
        }
        
        completion(model, nil);
    }
}
@end

@implementation ELEveryDayModel

+ (void)loadEventsData:(void (^)(NSArray *data))completeBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"events" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    EDays *days = [EDays yy_modelWithDictionary:dict];
    if (completeBlock) {
        completeBlock(days.list);
    }
}

+ (void)loadThemesData:(void(^)(NSArray *data))completeBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"themes" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    EThemes *themes = [EThemes yy_modelWithDictionary:dict];
    if (completeBlock) {
        completeBlock(themes.list);
    }
}
@end
