//
//  JSNetworkTool.m
//  MajorForum
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSNetworkTool.h"

static JSNetworkTool *_instanceType = nil;

@implementation JSNetworkTool

+ (instancetype)sharedNetworkToolManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[JSNetworkTool alloc] init];
        _instanceType.responseSerializer.acceptableContentTypes = [_instanceType.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        _instanceType.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return _instanceType;
}

#pragma mark - 公共方法
- (void)requestUrlString: (NSString *)urlString
       withRequestMethod: (RequestMode)requestMethod
          withParameters: (id)parameters
                progress: (void(^)(NSProgress *downloadProgress))progress
                 success: (void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure: (void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    if (requestMethod == RequestModeGet) {
        [self GET:urlString parameters:parameters progress:progress success:success failure:failure];
    } else {
        [self POST:urlString parameters:parameters progress:progress success:success failure:failure];
    }
}

@end
