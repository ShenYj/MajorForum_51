//
//  JSBaseViewController.h
//  Ecg2GForPad
//
//  Created by ShenYj on 2017/10/31.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSNavigationBar.h"

@interface JSBaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

/** 自定义导航条 */
@property (nonatomic,strong) JSNavigationBar  *js_NavigationBar;
/** 自定义导航条Item */
@property (nonatomic,strong) UINavigationItem *js_navigationItem;
/*** contentView ***/
@property (nonatomic,strong) UIView           *js_contentView;
/*** 返回按钮 ***/
@property (nonatomic,strong) UIButton         *js_backButton;
/** 表格控件 */
@property (nonatomic,strong) UITableView      *js_tableView;
/** 状态栏高度 */
@property (nonatomic,assign,readonly) CGRect  statusBarRect;

/** 子类实现用于自定义界面 */
- (void)setUpView;

@end
