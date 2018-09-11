//
//  UIImageView+JS_IV.m
//  MajorForum
//
//  Created by ecg on 2018/9/11.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "UIImageView+JS_IV.h"

@implementation UIImageView (JS_IV)

- (void)js_URLString: (NSString *)urlStr
         placeHolder: (UIImage *)placeHolderImg {
    [self yy_setImageWithURL:[NSURL URLWithString:urlStr] placeholder:placeHolderImg];
}

@end
