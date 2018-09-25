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
//        _instanceType.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _instanceType.responseSerializer = [AFXMLParserResponseSerializer serializer];
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//        securityPolicy.validatesDomainName = NO;
//        securityPolicy.allowInvalidCertificates = YES;
//        _instanceType.securityPolicy = securityPolicy;
    });
    return _instanceType;
}

//https证书
+ (AFSecurityPolicy*)customSecurityPolicy {
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"hd1.graland.com" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName      = YES;
    securityPolicy.pinnedCertificates       = [NSSet setWithObject:certData];
    
    return securityPolicy;
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
