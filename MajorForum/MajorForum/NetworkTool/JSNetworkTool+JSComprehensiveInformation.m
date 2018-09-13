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

- (void)getComprehensiveInformationNewDatas:(NSInteger)pageIdx FinishedBlock:(void (^)(id, NSError *error))finishedBlock {
    
    // https://forum.51nb.com/forum.php?mod=guide&view=new
    // https://forum.51nb.com/forum.php?mod=guide&view=new&page=2
    
    
//    An SSL error has occurred and a secure connection to the server cannot be made
//    https://forum.51nb.com/forum.php?mod=guide&view=new
    NSDictionary *parameters = @{
                                 @"r": @"forum/topiclist",
//                                 @"mod":@"guide",
//                                 @"view":@"new",
                                 @"page": @(pageIdx).stringValue
                                 };
    
    [self requestUrlString:HomePageNewTopicsUrlString withRequestMethod:RequestModeGet withParameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        finishedBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finishedBlock(nil, error);
    }];
}

@end
