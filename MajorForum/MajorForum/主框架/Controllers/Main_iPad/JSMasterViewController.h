//
//  JSMasterViewController.h
//  Ecg2GForPad
//
//  Created by ecg on 2017/10/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSMasterViewController : UIViewController

/*!
 *  @metohd updateSubViewsWithPortrait:
 *
 *  @param portrait      当前设备状态, 是否竖屏
 *
 *  @discussion          根据横竖屏情况,设置子视图的布局
 */
- (void)updateSubViewsWithPortrait:(BOOL)portrait;

/*!
 *  @metohd showContainerView:
 *
 *  @param show          是否展示容器视图
 *
 *  @discussion          根据是否分屏显隐视图
 */
- (void)showContainerView:(BOOL)show;

@end
