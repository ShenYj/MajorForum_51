//
//  JSComprehensiveInformationVC_iPad.m
//  MajorForum
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSComprehensiveInformationVC_iPad.h"
#import "JSDetailViewController.h"

@interface JSComprehensiveInformationVC_iPad () <JSDetailViewControllerProtocol>

@end

@implementation JSComprehensiveInformationVC_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- JSDetailViewControllerProtocol
// 实现协议方法
- (void)segmentValueChanged:(UISegmentedControl *)segment{
    NSLog(@"%zd",segment.selectedSegmentIndex);
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
