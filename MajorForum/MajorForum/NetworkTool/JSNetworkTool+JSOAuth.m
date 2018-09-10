//
//  JSNetworkTool+JSOAuth.m
//  MajorForum
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSNetworkTool+JSOAuth.h"

@implementation JSNetworkTool (JSOAuth)

#pragma mark - 登录
- (void)loginWithParameters:(NSDictionary *)parameters withFinishedBlock:(void (^)(id response, NSError *error))finishedBlock {
    
    NSString *getSetting = @"{\"body\" : {\"postInfo\" : {\"forumIds\" : \"0\"}}}";
    NSDictionary *para = @{
                           //@"username": parameters[@"username"],
                           //@"password": parameters[@"password"],
                           //@"username": @"%E6%88%91%E6%98%AF%E5%8E%9A%E8%B9%BC%E7%9A%84%E5%B0%8F%E5%8F%B7",
                           //@"password": @"123456789",
                           @"username": @"Ryans",
                           @"password": @"SYj54394419",
                           @"isValidation": @"1",
                           @"type": @"login",
                           @"getSetting":getSetting,
                           //@"apphash": @"8f34970d",
                           //@"forumKey": @"fkM0wfUNUsWf0VQxPD",
                           //@"accessToken": @"30f3316ea63835d8ba5c2268fad70",
                           //@"accessSecret":@"fc3568980c154e0629e614756ce3c"
                           };
    NSMutableDictionary *mPara = [NSMutableDictionary dictionaryWithCapacity:1];
    [para enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mPara setObject:obj forKey:key];
    }];
    [self requestUrlString:longinUrlString withRequestMethod:RequestModePost withParameters:mPara.copy progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        finishedBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finishedBlock(nil, error);
    }];
}

@end
