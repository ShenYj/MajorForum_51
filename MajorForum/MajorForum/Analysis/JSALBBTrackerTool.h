//
//  JSALBBTrackerTool.h
//  MajorForum
//
//  Created by ecg on 2018/9/17.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSALBBTrackerTool : NSObject

@property (nonatomic,strong) ALBBMANPageHitBuilder *pageHitBuilder;

+ (instancetype)sharedBuilder;
- (nullable NSString *)getCurClsName:(Class)cla;

@end

NS_ASSUME_NONNULL_END
