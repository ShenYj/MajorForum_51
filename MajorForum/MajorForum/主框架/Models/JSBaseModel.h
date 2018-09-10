//
//  JSBaseModel.h
//  MajorForum
//
//  Created by ecg on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSMasterItem;
@interface JSBaseModel : NSObject

/*** 模型对象实例化方法: 实例方法 + 静态方法 ***/
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

/*** 输出属性类型 ***/
+ (void)js_logJsonKeyValueClass:(NSDictionary *)dict;


@end
