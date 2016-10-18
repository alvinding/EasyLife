//
//  ELClassifyModel.m
//  EasyLife
//
//  Created by dingchuan on 16/10/13.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELClassifyModel.h"

@implementation ELClassifyModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ELClassModel class]};
}

+ (void)loadClassifyModel:(void (^)(ELClassifyModel *, NSError *))completion {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Classify" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        ELClassifyModel *model = [ELClassifyModel yy_modelWithJSON:dict];
    
        completion(model, nil);
    }
}
@end

@implementation ELClassModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tags" : [ELEveryClassModel class]};
}

@end

@implementation ELEveryClassModel
@end