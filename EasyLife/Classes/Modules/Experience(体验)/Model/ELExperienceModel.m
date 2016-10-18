//
//  ELExperienceModel.m
//  EasyLife
//
//  Created by dingchuan on 16/10/10.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import "ELExperienceModel.h"

@implementation ELExperienceModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"head" : [ExperienceHeadModel class], @"list" : [EventModel class]};
}

+ (void)loadExperienceModel:(void (^)(ELExperienceModel *data, NSError *error))completion {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Experience" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        ELExperienceModel *model = [ELExperienceModel yy_modelWithJSON:dict];
        
        completion(model, nil);
    }
}
@end

@implementation ExperienceHeadModel

@end