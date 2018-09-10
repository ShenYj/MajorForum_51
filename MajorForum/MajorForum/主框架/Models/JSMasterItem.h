//
//  JSMasterItem.h
//  MajorForum
//
//  Created by ecg on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSBaseModel.h"

// 撰写区按钮模型类 记录撰写区按钮的数据
@interface JSMasterItem : JSBaseModel

// 菜单区模型数组
@property (nonatomic,strong,readonly,class) NSArray <JSMasterItem *> *menumItems;

// 按钮的标题
@property (nonatomic,copy) NSString *title;
// 按钮的图片名
@property (nonatomic,copy) NSString *imageName;
// 按钮所处区域标识
@property (nonatomic,assign,getter=isComposeArea) BOOL composeArea;
// 视图控制器名
@property (nonatomic,copy) NSString *controllerClassName;
// 分段控件的数据
@property (nonatomic,strong) NSArray *segmentItem;

// 类方法
+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
