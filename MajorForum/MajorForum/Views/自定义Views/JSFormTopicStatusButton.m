//
//  JSFormTopicStatusButton.m
//  MajorForum
//
//  Created by ecg on 2018/9/11.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSFormTopicStatusButton.h"

@implementation JSFormTopicStatusButton

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -4)];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font       = [UIFont systemFontOfSize:12];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

@end
