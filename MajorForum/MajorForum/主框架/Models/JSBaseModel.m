//
//  JSBaseModel.m
//  MajorForum
//
//  Created by ecg on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSBaseModel.h"

@implementation JSBaseModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (NSString *)description {
    NSArray *keys = [self.class js_objProperties];
    return [self dictionaryWithValuesForKeys:keys].description;
}

+ (void)js_logJsonKeyValueClass:(NSDictionary *)dict {
    NSArray *keys = [dict allKeys];
    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
    for (int i = 0; i < keys.count; i ++) {
        NSString *propertyName = keys[i];
        id value = [dict objectForKey:propertyName];
        [temp setObject:[value class] forKey:propertyName];
    }
    NSLog(@"传入字典中k每个key对应value的类型为:\n%@\n",temp);
}

@end
