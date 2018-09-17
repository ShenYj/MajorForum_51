//
//  JSPersonalInformationVC.m
//  MajorForum
//
//  Created by ecg on 2018/9/17.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSPersonalInformationVC.h"

@interface JSPersonalInformationVC ()

@end

@implementation JSPersonalInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI_common];
    if (IS_IPAD) {
        [self setUpUI_iPad];
    } else {
        [self setUpUI_iPhone];
    }
}

#pragma mark - set up view

- (void)setUpUI_common {
    self.view.backgroundColor = [UIColor js_randomColor];
    self.js_contentView.backgroundColor = [UIColor js_randomColor];
    [self.js_tableView removeFromSuperview];
    self.js_navigationItem.title = @"我的信息";
    
    // 关闭按钮
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"close@3x.png" ofType:nil];
    //self.js_navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithContentsOfFile:imgPath] style:UIBarButtonItemStyleDone target:self action:@selector(closeCurrentViewController)];
    UIButton *closeBtn = [[UIButton alloc] init];
    closeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [closeBtn setBackgroundImage:[UIImage imageWithContentsOfFile:imgPath] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeCurrentViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.js_NavigationBar addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.js_NavigationBar).mas_offset(20);
        make.centerY.mas_equalTo(self.js_NavigationBar);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
}

- (void)setUpUI_iPhone {
    
}

- (void)setUpUI_iPad {
    
}

#pragma mark - target

- (void)closeCurrentViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
