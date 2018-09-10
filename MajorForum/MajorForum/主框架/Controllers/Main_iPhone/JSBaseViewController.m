//
//  JSBaseViewController.m
//  Ecg2GForPad
//
//  Created by ShenYj on 2017/10/31.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import "JSBaseViewController.h"

/*** iPhone X 适配: 左右下边间距 ***/
static CGFloat const kiPhoneXViewMargin_L = 0;
static CGFloat const kiPhoneXViewMargin_R = 0;
static CGFloat const kiPhoneXViewMargin_B = 0;

/** 自定义导航条高度 */
static CGFloat const kNavigationBarHeight = 44.f;
//static CGFloat const kNavigationBarExtensionHeight = 88.f;

/*** 背景色 ***/
#define BackgroundColour [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0]

@interface JSBaseViewController ()


@end

@implementation JSBaseViewController

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        CGRect navRect    = self.navigationController.navigationBar.frame;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - target

- (void)goBackToParentController:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareCustomNavigationBar];
    // 设置视图
    [self setUpBaseView];
}

- (void)setUpBaseView {
    [self prepareBaseView];
}

/** 设置标题 */
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.js_navigationItem.title = title;
}

/** 导航条视图 */
- (void)prepareCustomNavigationBar {
    
    [self.view addSubview: self.js_NavigationBar];
    [self.view addSubview: self.js_contentView];

    self.js_NavigationBar.items        = @[self.js_navigationItem];
    self.js_NavigationBar.barTintColor = BackgroundColour;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName: THEME_COLOUR
                                 };
    [self.js_NavigationBar setTitleTextAttributes: attributes];
    self.js_contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.js_NavigationBar.translatesAutoresizingMaskIntoConstraints = NO;

    // navigationBar
    NSLayoutConstraint *navigationBarTop = [NSLayoutConstraint constraintWithItem: self.js_NavigationBar
                                                                        attribute: NSLayoutAttributeTop
                                                                        relatedBy: NSLayoutRelationEqual
                                                                           toItem: self.view
                                                                        attribute: NSLayoutAttributeTop
                                                                       multiplier: 1
                                                                         constant: 0];
    [self.view addConstraint:navigationBarTop];
    NSLayoutConstraint *navigationBarLeft = [NSLayoutConstraint constraintWithItem: self.js_NavigationBar
                                                                         attribute: NSLayoutAttributeLeft
                                                                         relatedBy: NSLayoutRelationEqual
                                                                            toItem: self.view
                                                                         attribute: NSLayoutAttributeLeft
                                                                        multiplier: 1
                                                                          constant: 0];
    [self.view addConstraint:navigationBarLeft];
    NSLayoutConstraint *navigationBarRight = [NSLayoutConstraint constraintWithItem: self.js_NavigationBar
                                                                          attribute: NSLayoutAttributeRight
                                                                          relatedBy: NSLayoutRelationEqual
                                                                             toItem: self.view
                                                                          attribute: NSLayoutAttributeRight
                                                                         multiplier: 1
                                                                           constant: 0];
    [self.view addConstraint:navigationBarRight];
    NSLayoutConstraint *navigationBarHeight = [NSLayoutConstraint constraintWithItem: self.js_NavigationBar
                                                                           attribute: NSLayoutAttributeHeight
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: nil
                                                                           attribute: NSLayoutAttributeNotAnAttribute
                                                                          multiplier: 1
                                                                            constant: self.js_NavigationBar.frame.size.height];
    [self.view addConstraint:navigationBarHeight];
    // contentView
    CGFloat contentViewLeftConstraint = IS_IPHONE_X ? kiPhoneXViewMargin_L : 0;
    CGFloat contentViewRightConstraint = IS_IPHONE_X ? kiPhoneXViewMargin_R : 0;
    CGFloat contentViewBottomConstraint = IS_IPHONE_X ? kiPhoneXViewMargin_B : 0;

    NSLayoutConstraint *contentViewTop = [NSLayoutConstraint constraintWithItem: self.js_contentView
                                                                      attribute: NSLayoutAttributeTop
                                                                      relatedBy: NSLayoutRelationEqual
                                                                         toItem: self.js_NavigationBar
                                                                      attribute: NSLayoutAttributeBottom
                                                                     multiplier: 1
                                                                       constant: 0];
    [self.view addConstraint:contentViewTop];
    NSLayoutConstraint *contentViewLeft = [NSLayoutConstraint constraintWithItem: self.js_contentView
                                                                       attribute: NSLayoutAttributeLeft
                                                                       relatedBy: NSLayoutRelationEqual
                                                                          toItem: self.view
                                                                       attribute: NSLayoutAttributeLeft
                                                                      multiplier: 1
                                                                        constant: contentViewLeftConstraint];
    [self.view addConstraint:contentViewLeft];
    NSLayoutConstraint *contentViewRight = [NSLayoutConstraint constraintWithItem: self.js_contentView
                                                                        attribute: NSLayoutAttributeRight
                                                                        relatedBy: NSLayoutRelationEqual
                                                                           toItem: self.view
                                                                        attribute: NSLayoutAttributeRight
                                                                       multiplier: 1
                                                                         constant: -contentViewRightConstraint];
    [self.view addConstraint:contentViewRight];
    NSLayoutConstraint *contentViewBottom = [NSLayoutConstraint constraintWithItem: self.js_contentView
                                                                         attribute: NSLayoutAttributeBottom
                                                                         relatedBy: NSLayoutRelationEqual
                                                                            toItem: self.view
                                                                         attribute: NSLayoutAttributeBottom
                                                                        multiplier: 1
                                                                          constant: -contentViewBottomConstraint];
    [self.view addConstraint:contentViewBottom];

    // 返回按钮
    //self.js_navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.js_backButton];
}
/** 主视图 */
- (void)prepareBaseView {
    // 设置基类视图背景色
    self.view.backgroundColor = BackgroundColour;
    // 取消穿透
    if (@available(iOS 11.0, *)) {
        self.js_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - lazy

- (JSNavigationBar *)js_NavigationBar {
    if (!_js_NavigationBar) {
        CGFloat statusH = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat height  = statusH + kNavigationBarHeight;
        _js_NavigationBar = [[JSNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    }
    return _js_NavigationBar;
}
- (UINavigationItem *)js_navigationItem {
    if (!_js_navigationItem) {
        _js_navigationItem = [[UINavigationItem alloc] init];
    }
    return _js_navigationItem;
}
- (UIView *)js_contentView {
    if (!_js_contentView) {
        _js_contentView = [[UIView alloc] init];
        _js_contentView.backgroundColor = [UIColor whiteColor];
    }
    return _js_contentView;
}
- (UIButton *)js_backButton {
    if (!_js_backButton) {
        _js_backButton = [[UIButton alloc] init];
        _js_backButton.frame = CGRectMake(0, 0, 40, 40);
        _js_backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_js_backButton setBackgroundImage:[UIImage imageNamed:@"base_back"] forState:UIControlStateNormal];
        [_js_backButton setTitle: @""
                        forState: UIControlStateNormal];
        [_js_backButton addTarget: self
                           action: @selector(goBackToParentController:)
                 forControlEvents: UIControlEventTouchUpInside];
    }
    return _js_backButton;
}

@end
