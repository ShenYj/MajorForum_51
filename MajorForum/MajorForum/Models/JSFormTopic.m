//
//  JSFormTopic.m
//  MajorForum
//
//  Created by ecg on 2018/9/11.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSFormTopic.h"

@implementation JSFormTopic

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"imageList": [NSString class],
             @"verify": [NSString class]
             };
}

@end
