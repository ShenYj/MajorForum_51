//
//  JSMasterItem.m
//  MajorForum
//
//  Created by ecg on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSMasterItem.h"

static NSArray <JSMasterItem *> *_menumItems;

@implementation JSMasterItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    // 创建模型对象
    JSMasterItem *item = [[self alloc] init];
    // KVC
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

+ (NSArray <JSMasterItem *> *)menumItems {
    if (_menumItems == nil) {
        NSArray *data = @[
                          @{ @"title":@"综合资讯", @"imageName":@"tabBar_news", @"controllerClassName":@"JSBaseViewController", @"segmetnItem":@[@"全部动态",@"好友动态"]},
                          @{ @"title":@"ThinkPad技术论坛", @"imageName":@"tabBar_ThinkPad", @"controllerClassName":@"JSBaseViewController"},
                          @{ @"title":@"智能手机与外设专区", @"imageName":@"tabBar_MobilePhone", @"controllerClassName":@"JSBaseViewController"},
                          @{ @"title":@"品牌笔记本专区", @"imageName":@"tabBar_OtherLaptops", @"controllerClassName":@"JSBaseViewController"},
                          @{ @"title":@"交易与市场论坛", @"imageName":@"tabBar_Business", @"controllerClassName":@"JSBaseViewController", @"segmetnItem":@[@"我的好友",@"特别关注"]},
                          @{ @"title":@"系统与软件专区", @"imageName":@"tabBar_Software", @"controllerClassName":@"JSBaseViewController"},
                          @{ @"title":@"论坛与站务公告", @"imageName":@"tabBar_Gonggao", @"composeArea":@YES, @"controllerClassName":@"JSBaseViewController" },
                          @{ @"title":@"内部事项", @"imageName":@"tabBar_Shiwu", @"composeArea":@YES, @"controllerClassName":@"JSBaseViewController" },
                          @{ @"title":@"个人中心", @"imageName":@"tabBar_Mine", @"composeArea":@YES, @"controllerClassName":@"JSBaseViewController"  }
                          ];
        
        NSMutableArray *mArr = [NSMutableArray array];
        // 字典转模型
        for (NSDictionary *dict in data) {
            JSMasterItem *item = [JSMasterItem itemWithDict:dict];
            [mArr addObject:item];
        }
        _menumItems = mArr.copy;
    }
    return _menumItems;
}


@end
