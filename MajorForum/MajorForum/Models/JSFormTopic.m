//
//  JSFormTopic.m
//  MajorForum
//
//  Created by ecg on 2018/9/11.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSFormTopic.h"

@implementation JSFormTopic

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"imageList": [NSString class],
             @"verify": [NSString class]
             };
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[JSFormTopic class]]) {
        return NO;
    }
    return [self isEqualToModel:(JSFormTopic *)object];
}

- (NSUInteger)hash {
    return [self.topic_id hash ] << 8 ^ [self.user_id hash];
}

- (BOOL)isEqualToModel:(JSFormTopic *)model {
    if (!model) {
        return NO;
    }
    BOOL isTopicIDEqual = (!self.topic_id && !model.topic_id) || [self.topic_id.stringValue isEqualToString:model.topic_id.stringValue];
    BOOL isUserIDEqual = (!self.user_id && !model.user_id) || [self.user_id.stringValue isEqualToString:model.user_id.stringValue];
    return isTopicIDEqual && isUserIDEqual;
}



@end
