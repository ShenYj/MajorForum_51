//
//  main.m
//  MajorForum
//
//  Created by ShenYj on 2018/9/9.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

CFAbsoluteTime startTime;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        startTime = CFAbsoluteTimeGetCurrent();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
