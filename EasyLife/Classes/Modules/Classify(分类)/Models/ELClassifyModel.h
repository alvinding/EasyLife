//
//  ELClassifyModel.h
//  EasyLife
//
//  Created by dingchuan on 16/10/13.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface ELClassifyModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSArray *list;

+ (void)loadClassifyModel:(void (^)(ELClassifyModel *data, NSError *error))completion;
@end

@interface ELClassModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSArray *tags;
@end

@interface ELEveryClassModel : NSObject
@property (nonatomic, copy) NSString *ev_count;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@end