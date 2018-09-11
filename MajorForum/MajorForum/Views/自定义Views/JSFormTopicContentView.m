//
//  JSFormTopicContentView.m
//  MajorForum
//
//  Created by ecg on 2018/9/11.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSFormTopicContentView.h"

const CGFloat leftMargin = 10;

@interface JSFormTopicContentView ()

@property (nonatomic,strong) UIImageView *userIcon_imageView;             // 用户头像
@property (nonatomic,strong) UILabel     *userName_label;                 // 用户昵称
@property (nonatomic,strong) UILabel     *composeTimer_label;             // 发布时间
@property (nonatomic,strong) UILabel     *title_label;                    // 文章标题
@property (nonatomic,strong) UILabel     *subTitle_label;                 // 文章内容

@end

@implementation JSFormTopicContentView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.userIcon_imageView = [[UIImageView alloc] init];
    self.userIcon_imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.userName_label     = [[UILabel alloc] init];
    self.composeTimer_label = [[UILabel alloc] init];
    self.title_label        = [[UILabel alloc] init];
    self.subTitle_label     = [[UILabel alloc] init];
    
    [self addSubview:self.userIcon_imageView];
    [self addSubview:self.userName_label];
    [self addSubview:self.composeTimer_label];
    [self addSubview:self.title_label];
    [self addSubview:self.subTitle_label];
    
    [self.userIcon_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).mas_offset(leftMargin);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.userName_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userIcon_imageView.mas_right).mas_offset(leftMargin);
        make.top.mas_equalTo(self.userIcon_imageView);
    }];
    
    [self.composeTimer_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userIcon_imageView.mas_right).mas_offset(leftMargin);
        make.bottom.mas_equalTo(self.userIcon_imageView);
    }];
    
    [self.title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userIcon_imageView.mas_bottom).mas_offset(leftMargin);
        make.left.mas_equalTo(self.userIcon_imageView);
        make.right.mas_equalTo(self).mas_offset(-leftMargin);
        make.height.mas_equalTo(15);
    }];
    
    [self.subTitle_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.title_label);
        make.top.mas_equalTo(self.title_label.mas_bottom).mas_offset(leftMargin);
        make.bottom.mas_equalTo(self).mas_offset(-leftMargin);
    }];
    // 设置假数据
    [self setUpSubViews];
}

- (void)setUpSubViews {
    
    self.userIcon_imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.userName_label.font            = [UIFont systemFontOfSize:12];
    self.userName_label.textColor       = [UIColor blackColor];
    
    self.composeTimer_label.font      = [UIFont systemFontOfSize:10];
    self.composeTimer_label.textColor = [UIColor lightGrayColor];
    self.composeTimer_label.text      = @"";
    
    self.title_label.font          = [UIFont systemFontOfSize:13];
    self.title_label.textColor     = [UIColor blackColor];
    self.title_label.numberOfLines = 1;
    self.title_label.contentMode   = UIViewContentModeLeft;
    self.title_label.text          = @"";
    
    self.subTitle_label.font          = [UIFont systemFontOfSize:12];
    self.subTitle_label.textColor     = [UIColor lightGrayColor];
    self.subTitle_label.contentMode   = UIViewContentModeLeft;
    self.subTitle_label.numberOfLines = 2;
    self.subTitle_label.text = @"";
}
- (void)setTopicModel:(JSFormTopic *)topicModel {
    
    _topicModel = topicModel;
    
    [self.userIcon_imageView js_URLString:topicModel.userAvatar
                              placeHolder:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"userDefault.png" ofType:nil]]];
    self.userName_label.text = topicModel.user_nick_name;   // 用户昵称
    self.title_label.text    = topicModel.title;            // 标题
    self.subTitle_label.text = topicModel.subject;          // 副标题
}

@end
