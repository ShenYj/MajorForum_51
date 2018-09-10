//
//  JSPhoneTabBarController.m
//  MajorForum
//
//  Created by ShenYj on 2018/9/9.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSPhoneTabBarController.h"

@interface JSPhoneTabBarController ()

@end

@implementation JSPhoneTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 设置自定义TabBar
//    JSTabBar *tabBar = [[JSTabBar alloc] init];
//    // 自定义TabBar的ComposeButton点击回调Block
//    [tabBar setComposeButtonBlock:^{
//        JSComposeViewController *composeViewController = [[JSComposeViewController alloc] initWithTitle:@"写说说" completeBlock:nil];
//        composeViewController.view.backgroundColor = [UIColor randomColor];
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:composeViewController];
//        [self presentViewController:navigationController animated:YES completion:nil];
//    }];
//    [self setValue:tabBar forKey:@"tabBar"];
    
    self.tabBar.tintColor = THEME_COLOUR;
    
    // 添加子控制器
    [self addChildViewControllers:[[JSBaseViewController alloc] init] withImageName:@"tabbar_home" withTitle:@"首页"];
    [self addChildViewControllers:[[JSBaseViewController alloc] init] withImageName:@"tabbar_discover" withTitle:@"板块"];
    [self addChildViewControllers:[[JSBaseViewController alloc] init] withImageName:@"tabbar_message" withTitle:@"消息"];
    [self addChildViewControllers:[[JSBaseViewController alloc] init] withImageName:@"tabbar_mine" withTitle:@"我的"];
    
}

// 添加子控制器&设置子控制器标题和图片
- (void)addChildViewControllers:(JSBaseViewController *)viewController withImageName:(NSString *)imageName withTitle:(NSString *)title {
    
    UIImage *image         = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]];
//    UIImage *selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.js_navigationItem.title  = title;
    viewController.tabBarItem.title         = title;
    viewController.tabBarItem.image         = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    
    // 设置tabbarItem字体颜色
    [viewController.tabBarItem setTitleTextAttributes: @{ NSForegroundColorAttributeName: THEME_COLOUR }
                                             forState: UIControlStateSelected];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
