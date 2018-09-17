//
//  UIViewController+JSAnalysis.m
//  MajorForum
//
//  Created by ecg on 2018/9/17.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "UIViewController+JSAnalysis.h"


@implementation UIViewController (JSAnalysis)

+ (void)load {
    //    NSString *className = NSStringFromClass(self.class);
    //    NSLog(@"%@", className);
    [self replaceOrExchangeMethodOriginSelector:@selector(viewDidAppear:) SwizzledSelector:@selector(my_viewDidAppear:)];
    [self replaceOrExchangeMethodOriginSelector:@selector(viewDidDisappear:) SwizzledSelector:@selector(my_viewDidDisappear:)];
}

- (void)my_viewDidAppear:(BOOL)animated {
    NSString *className = NSStringFromClass(self.class);
    [[ALBBMANPageHitHelper getInstance] pageAppear:self];
    // 设置页面名称
    NSString *pageName = [[JSALBBTrackerTool sharedBuilder] getCurClsName:self.class];
    if (pageName) [[JSALBBTrackerTool sharedBuilder].pageHitBuilder setPageName:pageName];
    // 设置页面来源
    if (IS_IPHONE) {
        UIResponder *responder = self.nextResponder;
        while (responder) {
            if ([responder isKindOfClass:[UIViewController class]]) {
                NSLog(@" %@", responder.class);
                break;
            } else {
                responder = responder.nextResponder;
            }
        }
        Class sourceCls = responder.class;
        NSString *sourceClsName = nil;
        sourceClsName = [[JSALBBTrackerTool sharedBuilder] getCurClsName:sourceCls];
        if (sourceClsName) [[JSALBBTrackerTool sharedBuilder].pageHitBuilder setReferPage:sourceClsName];
    }
    if (IS_IPAD) {
        NSLog(@"%zd", self.splitViewController.childViewControllers.count);
        NSInteger idx = self.navigationController.childViewControllers.count - 2;
        if (idx < 0) return;
        Class sourceCls = [self.navigationController.childViewControllers[idx] class];
        NSString *sourceClsName = nil;
        sourceClsName = [[JSALBBTrackerTool sharedBuilder] getCurClsName:sourceCls];
        NSLog(@" 来源视图: %@ ",sourceClsName);
        if (sourceClsName) [[JSALBBTrackerTool sharedBuilder].pageHitBuilder setReferPage:sourceClsName];
        
        NSLog(@" className: %@  -- 中文名: %@", className, pageName);
    }
    [self my_viewDidAppear:animated];
}

- (void)my_viewDidDisappear:(BOOL)animated {
    NSString *className = NSStringFromClass(self.class);
    if ( ![className isEqualToString:@"JSBaseNavigationController"] && ![className isEqualToString:@"JSSplitController"] && ![className isEqualToString:@"JSBaseViewController"] ) {
        // NSLog(@"%@", className);
        [[ALBBMANPageHitHelper getInstance] pageDisAppear:self];
    }
    [self my_viewDidDisappear:animated];
}

+ (void)replaceOrExchangeMethodOriginSelector:(SEL)originSelector
                             SwizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class,originSelector);
    Method swizzledMethod = class_getInstanceMethod(class,swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(
                                        class,
                                        originSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod)
                                        );
    
    if (didAddMethod) {
        class_replaceMethod(
                            class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod)
                            );
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
