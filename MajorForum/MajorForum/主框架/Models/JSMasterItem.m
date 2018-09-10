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
                          @{ @"title":@"综合资讯", @"imageName":@"tab_bar_feed_icon", @"controllerClassName":@"JSHomeTableViewController", @"segmetnItem":@[@"全部动态",@"好友动态"]},
                          @{ @"title":@"ThinkPad技术论坛", @"imageName":@"tab_bar_passive_feed_icon", @"controllerClassName":@"JSAboutMeTableViewController"},
                          @{ @"title":@"智能手机与外设专区", @"imageName":@"tab_bar_pic_wall_icon", @"controllerClassName":@"JSPictureWallCollectionViewController"},
                          @{ @"title":@"品牌笔记本专区", @"imageName":@"tab_bar_e_album_icon", @"controllerClassName":@"JSAlbumTableViewController"},
                          @{ @"title":@"交易与市场论坛", @"imageName":@"tab_bar_friend_icon", @"controllerClassName":@"JSMyFriendTableViewController", @"segmetnItem":@[@"我的好友",@"特别关注"]},
                          @{ @"title":@"系统与软件专区", @"imageName":@"tab_bar_e_more_icon", @"controllerClassName":@"JSMoreAppTableViewController"},
                          @{ @"title":@"论坛与站务公告", @"imageName":@"tabbar_mood", @"composeArea":@YES, @"controllerClassName":@"JSComposeViewController" },
                          @{ @"title":@"内部事项", @"imageName":@"tabbar_photo", @"composeArea":@YES, @"controllerClassName":@"JSComposeViewController" },
                          @{ @"title":@"个人中心", @"imageName":@"tabbar_blog", @"composeArea":@YES, @"controllerClassName":@"JSComposeViewController"  }
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
