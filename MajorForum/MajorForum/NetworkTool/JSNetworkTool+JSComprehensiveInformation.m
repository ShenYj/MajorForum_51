//
//  JSNetworkTool+JSComprehensiveInformation.m
//  MajorForum
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSNetworkTool+JSComprehensiveInformation.h"

@implementation JSNetworkTool (JSComprehensiveInformation)

#pragma mark -- 请求首页最新数据

- (void)getComprehensiveInformationNewDatasUrlString:(NSString *)urlString finishedBlock:(void (^)(id, NSError *error))finishedBlock {
    NSDictionary *parameters = @{
                                 @"r": @"forum/topiclist"
                                 };
    
    [self requestUrlString:HomePageNewTopicsUrlString withRequestMethod:RequestModeGet withParameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        finishedBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finishedBlock(nil, error);
    }];
}

@end
