//
//  ELExperienceModel.h
//  EasyLife
//
//  Created by dingchuan on 16/10/10.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELEveryDayModel.h"

@interface ExperienceHeadModel : NSObject
@property (nonatomic, copy) NSString *feel;
@property (nonatomic, copy) NSString *shareURL;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *adurl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *mobileURL;
@end

@interface ELExperienceModel : NSObject
@property (nonatomic, strong) NSArray *head;
@property (nonatomic, strong) NSArray *list;

+ (void)loadExperienceModel:(void (^)(ELExperienceModel *data, NSError *error))completion;
@end
