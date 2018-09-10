//
//  JSMasterButton.h
//  MajorForum
//
//  Created by ecg on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

// 常量
static const CGFloat kMenumButtonPortraitHeight = 60;
static const CGFloat kMenumButtonLandScapeHeight = 90;

@class JSMasterItem;
@interface JSMasterButton : UIButton

// 模型对象
@property (nonatomic,strong) JSMasterItem *item;

// 类方法创建
+ (instancetype)buttonWithItem:(JSMasterItem *)item;
// 对象方法
- (instancetype)initWithItem:(JSMasterItem *)item;
// 根据横竖屏情况设置菜单区视图布局
- (void)prepareContentEdgeWithPortrait:(BOOL)portrait;

@end
