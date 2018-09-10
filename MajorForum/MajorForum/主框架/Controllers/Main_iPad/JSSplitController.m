//
//  JSSplitController.m
//  Ecg2GForPad
//
//  Created by ecg on 2017/10/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSSplitController.h"
#import "JSMasterViewController.h"

@interface JSSplitController ()

/*** 主视图控制器 ***/
@property (nonatomic,strong) JSMasterViewController *masterViewController;

@end

@implementation JSSplitController

- (instancetype)init {
    self = [super init];
    if (self) {
        // 设置主视图
        self.masterViewController = [[JSMasterViewController alloc] init];
        [self addChildViewController:self.masterViewController];
        // 明细视图
        UIViewController *detailController = [[UIViewController alloc] init];
        detailController.view.backgroundColor = [UIColor js_randomColor];
        [self addChildViewController:detailController];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置SplitViewController
    [self prepareSplitViewController];
}

// 设置SplitViewController
- (void)prepareSplitViewController {
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    // 监听设备朝向变化通知
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(orientationDidChangeNotification)
                                                 name: UIDeviceOrientationDidChangeNotification
                                               object: nil];
}

// 监听设备朝向变化时调用的方法
- (void)orientationDidChangeNotification {
    // 设置主视图的宽度比例 (主视图宽度 / SplitVc整体宽度)  比例不好控制&受最大(maximumPrimaryColumnWidth)最小值(minimumPrimaryColumnWidth)约束
    // 直接设置最大宽度为一个固定值
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation);
    // 根据横竖屏变化,设置不同的主视图宽度
    if (isPortrait) {
        // 竖屏
        self.maximumPrimaryColumnWidth = 60;
    } else {
        // 横向
        self.maximumPrimaryColumnWidth = 200;
    }
    // 根据横竖屏更新撰写区子控件布局
    [self.masterViewController updateSubViewsWithPortrait:isPortrait];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITraitEnvironment

// 当SizeClass发生变化后调用
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    // 判断当前的SizeClass,如果为width compact&height regular 则说明正在分屏
    BOOL showContainer = (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) && (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular);
    [self.masterViewController showContainerView:showContainer];
    if (showContainer) {
        // 正在分屏
        NSLog(@"正在分屏");
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    } else {
        NSLog(@"没有分屏");
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}



@end
