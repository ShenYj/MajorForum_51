//
//  JSBaseViewController.h
//  Ecg2GForPad
//
//  Created by ShenYj on 2017/10/31.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSNavigationBar.h"

@interface JSBaseViewController : UIViewController

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

@end
