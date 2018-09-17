//
//  JSALBBTrackerTool.m
//  MajorForum
//
//  Created by ecg on 2018/9/17.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSALBBTrackerTool.h"

static JSALBBTrackerTool *_instanceTrackerTool = nil;

@interface JSALBBTrackerTool ()
{
    NSString *_filePath;
}

@property (nonatomic,strong) NSDictionary *clsName;
@property (nonatomic,strong) NSDictionary *targetName;
@property (nonatomic,strong) NSArray <NSDictionary *> *clsNames;
@property (nonatomic,strong) NSArray <NSDictionary *> *targertNames;


@end

@implementation JSALBBTrackerTool

+ (instancetype)sharedBuilder {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceTrackerTool = [[JSALBBTrackerTool alloc] init];
        _instanceTrackerTool->_filePath = [[NSBundle mainBundle] pathForResource:@"PageNameRelation.plist" ofType:nil];
    });
    return _instanceTrackerTool;
}

- (nullable NSString *)getCurClsName:(Class)cla {
    NSString *clsString = NSStringFromClass(cla);
    __block NSString *clsDisName = nil;
    [self.clsName.allKeys enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:clsString]) {
            clsDisName = [self.clsName objectForKey:clsString];
            *stop = YES;
        }
    }];
    return clsDisName;
}


#pragma mark - lazy

- (ALBBMANPageHitBuilder *)pageHitBuilder {
    if (!_pageHitBuilder) {
        _pageHitBuilder = [[ALBBMANPageHitBuilder alloc] init];
    }
    return _pageHitBuilder;
}

- (NSArray <NSDictionary *> *)clsNames {
    if (!_clsNames) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:_filePath];
        _clsNames = dict[@"clsName"];
    }
    return _clsNames;
}

- (NSArray <NSDictionary *> *)targertNames {
    if (!_targertNames) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:_filePath];
        _targertNames = dict[@"targetName"];
    }
    return _targertNames;
}

- (NSDictionary *)clsName {
    if (!_clsName) {
        _clsName = (NSDictionary *)self.clsNames.firstObject;
    }
    return _clsName;
}

- (NSDictionary *)targetName {
    if (!_targetName) {
        _targetName = (NSDictionary *)self.targertNames.firstObject;
    }
    return _targetName;
}

@end
