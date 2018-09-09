
/******************************************************
 
 @discusstion:   基类控制器
 
 @author：   ShenYj
 
 @email:    shenyj4@51nb.com
 
 ******************************************************/



#import "JSBaseNavigationController.h"

@interface JSBaseNavigationController () <UINavigationControllerDelegate>

// 记录push标志
@property (nonatomic, assign, getter=isPushing) BOOL pushing;
//@property (nonatomic,strong) UIButton                *backButton;

@end

@implementation JSBaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.hidden = YES;
    
    self.delegate = self;
//    [self.navigationBar setTitleTextAttributes:@{
//                                                 NSFontAttributeName: [UIFont systemFontOfSize:18],
//                                                 NSForegroundColorAttributeName: [UIColor js_colorWithHex:0x333333],
//                                                 }];
//    self.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 更换导航栏底边线条颜色
    [self changeNavigationbarBottomLineColor:[UIColor js_colorWithHex:0xe4e4e4]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.pushing == YES) {
        return;
    } else {
        self.pushing = YES;
    }
    
    if (self.childViewControllers.count > 0) {
        // 设置全局隐藏底部TabBar
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置返回按钮
//        if ([viewController isKindOfClass:[JSBaseViewController class]]) {
//            JSBaseViewController *nextVC = (JSBaseViewController *)viewController;
//            NSString *title = @"  ";    // 返回
//            if (self.childViewControllers.count == 1) {
//                JSBaseViewController *parentVC = self.childViewControllers.firstObject;
//                title = parentVC.navigationItem.title;
//            }
//            nextVC.navigationItem.leftBarButtonItem = nil;
//            [UIBarButtonItem appearance].tintColor = [UIColor grayColor];
//            nextVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
//        }
    }
    [super pushViewController:viewController animated:animated];
}

//- (void)goBackToParentController:(UIBarButtonItem *)sender
//{
//    [self popViewControllerAnimated:YES];
//}

/*** 隐藏导航栏底边的线 ***/
- (void)hideNavigationBarBottomLine
{
    [self.navigationBar.subviews enumerateObjectsUsingBlock: ^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ( iOS10 ) {
            // iOS10,改变了导航栏的私有接口为_UIBarBackground
            if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                //NSLog(@"_UIBarBackground");
                [view.subviews firstObject].hidden = YES;
            }
        } else {
            // iOS10之前使用的是_UINavigationBarBackground
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                //NSLog(@"_UINavigationBarBackground");
                [view.subviews firstObject].hidden = YES;
            }
        }
    }];
}

/*** 改变导航栏底边线的颜色 ***/
- (void)changeNavigationbarBottomLineColor:(UIColor *)colour
{
    // 查看View层次结构
    //[UIView logHierarchyWithThisView:self.navigationBar];
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    __block UIView *navigationbarLineView = nil;
    [self.navigationBar.subviews enumerateObjectsUsingBlock: ^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ( systemVersion >= 10.0 ) {
            // iOS10,改变了导航栏的私有接口为_UIBarBackground
            if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                //NSLog(@"_UIBarBackground");
                navigationbarLineView = view.subviews.firstObject;
            }
        } else {
            // iOS10之前使用的是_UINavigationBarBackground
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                //NSLog(@"_UINavigationBarBackground");
                navigationbarLineView = view.subviews.firstObject;
            }
        }
    }];
    if ( navigationbarLineView && [navigationbarLineView isKindOfClass:[UIImageView class]] ) {
        // 添加一个视图覆盖掉这条线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = colour;
        lineView.translatesAutoresizingMaskIntoConstraints = NO;
        [navigationbarLineView addSubview:lineView];
        
        [navigationbarLineView addConstraint: [NSLayoutConstraint constraintWithItem: lineView
                                                                           attribute: NSLayoutAttributeTop
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: navigationbarLineView
                                                                           attribute: NSLayoutAttributeTop
                                                                          multiplier: 1.0
                                                                            constant: 0.0]];
        [navigationbarLineView addConstraint: [NSLayoutConstraint constraintWithItem: lineView
                                                                           attribute: NSLayoutAttributeBottom
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: navigationbarLineView
                                                                           attribute: NSLayoutAttributeBottom
                                                                          multiplier: 1.0
                                                                            constant: 0.0]];
        [navigationbarLineView addConstraint: [NSLayoutConstraint constraintWithItem: lineView
                                                                           attribute: NSLayoutAttributeLeft
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: navigationbarLineView
                                                                           attribute: NSLayoutAttributeLeft
                                                                          multiplier: 1.0
                                                                            constant: 0.0]];
        [navigationbarLineView addConstraint: [NSLayoutConstraint constraintWithItem: lineView
                                                                           attribute: NSLayoutAttributeRight
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: navigationbarLineView
                                                                           attribute: NSLayoutAttributeRight
                                                                          multiplier: 1.0
                                                                            constant: 0.0]];
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.pushing = NO;
}

//#pragma mark - lazy
//- (UIButton *)backButton {
//    if (!_backButton) {
//        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _backButton.frame = CGRectMake(0, 0, SYRealValueW(60), 25);
//        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
//        [_backButton setImage:[UIImage imageNamed:@"back_Img"] forState:UIControlStateNormal];
//        [_backButton setTitle:@"    " forState:UIControlStateNormal];
//        [_backButton addTarget: self
//                        action: @selector(goBackToParentController:)
//              forControlEvents: UIControlEventTouchUpInside];
//    }
//    return _backButton;
//}


@end
