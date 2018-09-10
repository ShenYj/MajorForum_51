//
//  JSDetailViewController.h
//  Ecg2GForPad
//
//  Created by ecg on 2017/10/30.
//  Copyright © 2017年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSMasterItem;

@protocol JSDetailViewControllerProtocol <NSObject>

@optional
- (void)segmentValueChanged:(UISegmentedControl *)segment;

@end

@interface JSDetailViewController : UIViewController

- (instancetype)initWithMasterItem:(JSMasterItem *)item;

@end
