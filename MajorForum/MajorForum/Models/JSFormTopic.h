//
//  JSFormTopic.h
//  MajorForum
//
//  Created by ecg on 2018/9/11.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSBaseModel.h"

@interface JSFormTopic : JSBaseModel

@property (nonatomic,strong) NSNumber *board_id;
@property (nonatomic, copy ) NSString *board_name;
@property (nonatomic,strong) NSNumber *essence;
@property (nonatomic,strong) NSNumber *gender;
@property (nonatomic,strong) NSNumber *hits;
@property (nonatomic,strong) NSNumber *hot;
@property (nonatomic,strong) NSNumber *isHasRecommendAdd;
@property (nonatomic, copy ) NSString *last_reply_date;
@property (nonatomic, copy ) NSString *pic_path;
@property (nonatomic, copy ) NSString *ratio;
@property (nonatomic,strong) NSNumber *recommendAdd;
@property (nonatomic,strong) NSNumber *replies;
@property (nonatomic, copy ) NSString *sourceWebUrl;
@property (nonatomic,strong) NSNumber *special;
@property (nonatomic,strong) NSNumber *status;
@property (nonatomic, copy ) NSString *subject;
@property (nonatomic, copy ) NSString *title;
@property (nonatomic,strong) NSNumber *top;
@property (nonatomic,strong) NSNumber *topic_id;
@property (nonatomic, copy ) NSString *type;
@property (nonatomic, copy ) NSString *userAvatar;
@property (nonatomic, copy ) NSString *userTitle;
@property (nonatomic,strong) NSNumber *user_id;
@property (nonatomic, copy ) NSString *user_nick_name;
@property (nonatomic,strong) NSNumber *vote;

@property (nonatomic,strong) NSArray  *imageList;
@property (nonatomic,strong) NSArray  *verify;

@end
