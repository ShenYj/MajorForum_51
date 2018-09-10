//
//  JSNetworkTool.h
//  MajorForum
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "AFNetworking.h"
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RequestMode) {
    RequestModeGet,
    RequestModePost,
};

@interface JSNetworkTool : AFHTTPSessionManager

// 网络工具单例获取方法
+ (instancetype)sharedNetworkToolManager;
/** 公共方法  */
- (void)requestUrlString: (NSString *)urlString
       withRequestMethod: (RequestMode)requestMethod
          withParameters: (id)parameters
                progress: (void(^)(NSProgress *downloadProgress))progress
                 success: (void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure: (void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
