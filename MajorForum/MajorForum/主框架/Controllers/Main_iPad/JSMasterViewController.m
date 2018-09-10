//
//  JSMasterViewController.m
//  Ecg2GForPad
//
//  Created by ecg on 2017/10/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSMasterViewController.h"
#import "JSDetailViewController.h"
#import "JSMasterItem.h"
#import "JSMasterButton.h"

@interface JSMasterViewController ()

// 主视图容器
@property (nonatomic,  weak) UIView              *masterContainerView;
// 撰写区StackView
@property (nonatomic,strong) UIStackView         *composeArea_StackView;
// 菜单区StackView
@property (nonatomic,strong) UIStackView         *menuArea_StackView;
// 头像按钮
@property (nonatomic,strong) UIButton            *iconButton;
// 名称Label
@property (nonatomic,strong) UILabel             *nameLabel;
// 记录选中按钮
@property (nonatomic,strong) JSMasterButton      *selectedButton;
// 子控制器的缓存
@property (nonatomic,strong) NSMutableDictionary *subViewControllersCache;

@end

@implementation JSMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置菜单区视图
    [self prepareMenuView];
    [self setUpMasterView];
}

- (void)setUpMasterView {
    self.view.backgroundColor = [UIColor js_randomColor];
    // 设置容器视图
    [self prepareContainerView];
}

// 设置菜单区视图
- (void)prepareMenuView {
    // 添加子视图(UIButton)
    NSLog(@"菜单个数: %zd",JSMasterItem.menumItems.count);
    for (JSMasterItem *item in JSMasterItem.menumItems) {
        JSMasterButton *button = [[JSMasterButton alloc] initWithItem:item];
        if (item.isComposeArea) {
            // 撰写区
            [self.composeArea_StackView addArrangedSubview:button];
        } else {
            // 菜单区
            [self.menuArea_StackView addArrangedSubview:button];
        }
        // 设置事件监听
        [button addTarget:self action:@selector(clickMasterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 设置背景色
    self.view.backgroundColor = [UIColor colorWithWhite:34/255.0 alpha:1.0];
    // 设置默认选中按钮
    JSMasterButton *button = self.menuArea_StackView.subviews[0];
    [self clickMasterButton:button];
    
    /*   崩溃报错:  reason: '*** Collection <__NSArrayM: 0x7fe3dbc11bc0> was mutated while being enumerated.'
     原因:在可变集合进行快速遍历时,如果修改了其中元素的值就会崩溃报错 (for ,in快速遍历为了提高性能,内部使用了迭代器模式,根据当前遍历的数据选择不同的算法进行遍历,一旦遍历过程中修改了数据,会导致算法使用不正常,最终数据错误,iOS直接选择遇到修改立刻崩溃)
     这种问题一般都是运行时报错,出错的原因一般都是多线程导致的,一次调用_loadNewSubviews时,开始进行数据处理(快速遍历+改值),正好在第一次正在改值时,第二次调用了_loadNewSubviews方法开始尽心更快速遍历,导致崩溃
     
     解决此类问题一般两种方式: 1.设置延迟  2.去掉其中一次操作
     */
    // 设置头像视图
    [self prepareIconButton];
    // 设置昵称Label
    [self prepareNameLabel];
}
// 设置头像视图
- (void)prepareIconButton {
    // 设置头像图片
    [self.iconButton setImage:[UIImage imageNamed:@"default_person_lit"] forState:UIControlStateNormal];
    // 设置约束
    // button有固有尺寸,使用autolayout时,如果没有设置宽高,就会使用默认的系统设置进行宽高的设置:
    // 隐式调用sizeToFit方法,该方法会根据原始尺寸进行设置
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(20);
        // 设置左侧间距  利用水平居中的特性在竖屏时对头像视图进行压缩
        // 大于等于边距  既可以保证右侧间距也大于等于5(竖屏时会进行压缩),同时对横向宽度并不是具体值,这样autolayout就会根据固有尺寸设置button的宽高
        make.left.mas_greaterThanOrEqualTo(5);
        // 水平间距
        make.centerX.mas_equalTo(self.view);
        // 高度=宽度
        make.height.mas_equalTo(self.iconButton.mas_width);
    }];
}

// 设置昵称Label
- (void)prepareNameLabel {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconButton.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(self.view);
    }];
}

#pragma mark -- 代码实现容器视图:
- (void)prepareContainerView {
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
- (void)showContainerView:(BOOL)show {
    // 分屏时,代表主视图需要显示为iPhone样式,所以主视图上的容器视图显示( 隐藏=NO )
    self.masterContainerView.hidden = !show;
}

// 根据横竖屏设置子视图布局
- (void)updateSubViewsWithPortrait:(BOOL)portrait {
    if (portrait) {
        // 竖屏
        self.composeArea_StackView.axis = UILayoutConstraintAxisVertical;
        // 更新撰写区约束
        [self.composeArea_StackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.composeArea_StackView.subviews.count * kMenumButtonPortraitHeight);
            make.bottom.mas_equalTo(self.view).mas_offset(-30);
        }];
        // 设置昵称
        self.nameLabel.text = @"";
    } else {
        // 横屏
        self.composeArea_StackView.axis = UILayoutConstraintAxisHorizontal;
        [self.composeArea_StackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kMenumButtonLandScapeHeight);
            make.bottom.mas_equalTo(self.view);
        }];
        // 设置昵称
        self.nameLabel.text = @"一只耳";
    }
}

#pragma mark -- 事件响应
// 点击主视图按钮
- (void)clickMasterButton:(JSMasterButton *)sender {
    if (self.selectedButton == sender) {
        return;
    }
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    // 判断按钮类型
    if (sender.item.isComposeArea) {
        // 撰写区
//        JSComposeViewController *composeViewController = [[JSComposeViewController alloc] initWithTitle:sender.item.title completeBlock:^{
//            self.selectedButton.selected = NO;
//            self.selectedButton = nil;
//        }];
//        composeViewController.view.backgroundColor = [UIColor randomColor];
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:composeViewController];
//        // 设置modal展示样式
//        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
//        // 进行modal展示
//        [self presentViewController:navigationController animated:YES completion:nil];
//        return;
    }
    // 如果缓存中存在子视图控制器,直接获取
    JSDetailViewController *detailViewController = self.subViewControllersCache[sender.item.title];
    if (detailViewController == nil) {
        // 如果缓存中没有子视图控制器,先创建,再存入缓存中
        detailViewController = [[JSDetailViewController alloc] initWithMasterItem:sender.item];
        // 将子控制器存储到缓存
        [self.subViewControllersCache setObject:detailViewController forKey:sender.item.title];
    }
    // 切换子视图控制器
    [self.splitViewController showDetailViewController:detailViewController sender:self];
    // 切换明细视图控制器
    /*
     参数1: 新的明细控制器 (如果已经存在明细控制器,且原来的明细控制器没有其他强引用,则切换新明细控制器后,圆明细控制器由于没有强引用会被释放
     参数2: 事件响应的发起者 (控制器) ,事件响应者链条监听中需要根据这个参数判断是哪个控制器 ; 当前在主视图控制器下,所以传入self ,但这里并不会使用到,也可以传入nil
     */
    
    //    UIViewController *detail = [[UIViewController alloc] init];
    //    detail.view.backgroundColor = [UIColor randomColor];
    //    [self.splitViewController showDetailViewController:detail sender:self];
    /*
     切换主视图控制器或明细控制器
     具体切换哪个位置上的控制器由sender来确定:
     如果sender为当前的主视图控制器,则切换到主视图控制器的位置上
     如果sender为明细视图控制器,则切换到明细视图控制器的位置上
     //     */
    //    UIViewController *master = [[UIViewController alloc] init];
    //    [self.splitViewController showViewController:master sender:self];
    // 切换明细视图控制器
    //    [self.splitViewController showViewController:detail sender:self.splitViewController.viewControllers[1]];
}

- (void)didReceiveMemoryWarning {
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

