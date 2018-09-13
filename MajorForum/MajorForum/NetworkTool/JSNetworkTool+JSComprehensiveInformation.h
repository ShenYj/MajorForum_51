//
//  JSNetworkTool+JSComprehensiveInformation.h
//  MajorForum 最新数据
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSNetworkTool.h"

@interface JSNetworkTool (JSComprehensiveInformation)

- (void)getComprehensiveInformationNewDatas:(NSInteger)pageIdx FinishedBlock:(void (^)(id, NSError *error))finishedBlock;

@end
