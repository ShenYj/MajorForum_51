//
//  JSMasterButton.m
//  MajorForum
//
//  Created by ecg on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSMasterItem.h"
#import "JSMasterButton.h"



@implementation JSMasterButton

+ (instancetype)buttonWithItem:(JSMasterItem *)item {
    return [[self alloc]initWithItem:item];
}

- (instancetype)initWithItem:(JSMasterItem *)item {
    self = [super init];
    if (self) {
        // 记录数据
        _item = item;
        // 设置ButtonUI
        [self setupUI];
    }
    return self;
}

//- (void)setHighlighted:(BOOL)highlighted{
//    取消系统默认的高亮状态渲染
//}

- (void)setupUI {
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    // 取消系统默认的高亮状态渲染
    self.adjustsImageWhenHighlighted = NO;
    // 设置正常状态图片
    [self setImage:[UIImage imageNamed:_item.imageName] forState:UIControlStateNormal];
    // 设置选中背景图
    [self setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    // 分隔线
    UIImageView *seperatorImageView = [[UIImageView alloc] init];
    [self addSubview:seperatorImageView];
    
    if (_item.isComposeArea) {
        // 撰写区
        // 分割线ImageView
        seperatorImageView.image = [UIImage imageNamed:@"tabbar_separate_g_line_v"];
        [seperatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(self);
            make.width.mas_equalTo(2);
        }];
    } else {
        // 菜单区
        // button自身约束
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kMenumButtonPortraitHeight);
        }];
        // 分割线ImageView
        seperatorImageView.image = [UIImage imageNamed:@"tabbar_separate_line"];
        [seperatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(2);
        }];
    }
}

// 根据横竖屏情况设置菜单区视图的内容间距
- (void)prepareContentEdgeWithPortrait:(BOOL)portrait {
    // 设置菜单区视图布局
    if (portrait) {
        // 竖屏
        // button整体内容左对齐
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // 设置图片间距
        self.imageEdgeInsets = UIEdgeInsetsZero;
        // 设置图片间距
        self.imageEdgeInsets = UIEdgeInsetsZero;
        // 设置标题
        [self setTitle:nil forState:UIControlStateNormal];
    } else {
        // 横屏
        // button整体内容左对齐
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置图片间距
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        // 设置文字的间距
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        // 设置标题
        [self setTitle:_item.title forState:UIControlStateNormal];
    }
}

@end
