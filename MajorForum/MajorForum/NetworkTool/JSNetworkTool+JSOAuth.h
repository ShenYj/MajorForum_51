//
//  JSNetworkTool+JSOAuth.h
//  MajorForum
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSNetworkTool.h"

@interface JSNetworkTool (JSOAuth)

- (void)loginWithParameters:(NSDictionary *)parameters withFinishedBlock:(void (^)(id response, NSError *error))finishedBlock;

@end
