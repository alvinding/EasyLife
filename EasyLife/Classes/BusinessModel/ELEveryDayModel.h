//
//  ELEveryDayModel.h
//  EasyLife
//
//  Created by dingchuan on 16/9/23.
//  Copyright © 2016年 alvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface ThemeModel : NSObject
@property (nonatomic, copy) NSString *themeurl;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hasweb;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *themeid;
@property (nonatomic, copy) NSString *text;
@end

@interface GuessLikeModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *imgs;
@property (nonatomic, copy) NSString *address;
@end

@interface EventModel : NSObject
@property (nonatomic, copy) NSString *feel;
@property (nonatomic, copy) NSString *shareURL;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *questionURL;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *eventid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *feeltitle;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSArray *imgs;
@property (nonatomic, strong) NSArray *more;
@property (nonatomic, copy) NSString *mobileURL;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *isShowDis;
@property (nonatomic, copy) NSString *distanceForUser;
@end

@interface EDay : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, strong) NSArray *themes;
@property (nonatomic, strong) NSArray *events;
@end

@interface EDays : NSObject
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, copy) NSString *code;
@end

@interface EThemes : NSObject
@property (nonatomic, copy) NSString *lastdate;
@property (nonatomic, strong) NSArray *list;
@end

@interface ELDetailModel : NSObject
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSArray *list;

+(void)loadDetails:(void (^)(ELDetailModel *detailModel, NSError *error))completeBlock;
+(void)loadMore:(void (^)(ELDetailModel *detailModel, NSError *error))completeBlock;
+(void)loadNearDatas:(void (^)(ELDetailModel *detailModel, NSError *error))completeBlock;
@end

@interface ELEveryDayModel : NSObject
/**
 *  使用本地的json数据
 *
 *  @param completeBlock <#completeBlock description#>
 */
+ (void)loadEventsData:(void (^)(NSArray *data))completeBlock;
+ (void)loadThemesData:(void (^)(NSArray *data))completeBlock;
@end

