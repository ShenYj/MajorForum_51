//
//  JSComprehensiveInformationVC_iPad.h
//  MajorForum
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSBaseViewController.h"

typedef NS_ENUM(NSUInteger, ComprehensiveInformationType) {
    ComprehensiveInformationTypeNewPosts,
    ComprehensiveInformationTypeEssential,
};

@interface JSComprehensiveInformationVC_iPad : JSBaseViewController

@property (nonatomic,assign) ComprehensiveInformationType ciType;

@end
