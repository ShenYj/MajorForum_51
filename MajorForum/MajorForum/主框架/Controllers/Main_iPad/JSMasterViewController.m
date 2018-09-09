//
//  JSMasterViewController.m
//  Ecg2GForPad
//
//  Created by ecg on 2017/10/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSMasterViewController.h"
#import "JSDetailViewController.h"


@interface JSMasterViewController ()

// 主视图容器
@property (nonatomic,  weak) UIView              *masterContainerView;
// 子控制器的缓存
@property (nonatomic,strong) NSMutableDictionary *subViewControllersCache;

@end

@implementation JSMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpMasterView];
}

- (void)setUpMasterView
{
    self.view.backgroundColor = [UIColor js_randomColor];
    // 设置容器视图
    [self prepareContainerView];
}

#pragma mark -- 代码实现容器视图:
- (void)prepareContainerView
{
    //容器视图使用场景:内嵌视图控制器
    JSPhoneTabBarController *tabBarController = [[JSPhoneTabBarController alloc] init];
    // 此控制器的View就相当于容器
    [self addChildViewController:tabBarController];
    // 添加内嵌控制器的视图为子视图 让内嵌的内容显示
    [self.view addSubview:tabBarController.view];
    // 设置属性引用 不是代码实现容器视图的必须环节(下面需要使用这个容器视图,设置显隐)
    self.masterContainerView = tabBarController.view;
}

// 根据是否分屏显隐视图
- (void)showContainerView:(BOOL)show
{
    // 分屏时,代表主视图需要显示为iPhone样式,所以主视图上的容器视图显示( 隐藏=NO )
    self.masterContainerView.hidden = !show;
}

// 根据横竖屏设置子视图布局
- (void)updateSubViewsWithPortrait:(BOOL)portrait
{
    if (portrait) {
        // 竖屏
        
    } else {
        // 横屏
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- lazy

- (NSMutableDictionary *)subViewControllersCache {
    if (!_subViewControllersCache) {
        _subViewControllersCache = [NSMutableDictionary dictionary];
    }
    return _subViewControllersCache;
}

@end

