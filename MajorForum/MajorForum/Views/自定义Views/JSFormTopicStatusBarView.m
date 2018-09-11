//
//  JSFormTopicStatusBarView.m
//  MajorForum
//
//  Created by ecg on 2018/9/11.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSFormTopicStatusBarView.h"
#import "JSFormTopicStatusButton.h"


extern CGFloat leftMargin;
@interface JSFormTopicStatusBarView ()

@property (nonatomic,strong) JSFormTopicStatusButton *readCountBtn;
@property (nonatomic,strong) JSFormTopicStatusButton *commentBtn;

@end

@implementation JSFormTopicStatusBarView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.readCountBtn];
    [self addSubview:self.commentBtn];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-leftMargin);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [self.readCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.commentBtn);
        make.centerY.mas_equalTo(self.commentBtn);
        make.right.mas_equalTo(self.commentBtn.mas_left).mas_offset(-leftMargin);
    }];
}

- (void)setTopicModel:(JSFormTopic *)topicModel {
    _topicModel = topicModel;
    
    [self.readCountBtn setTitle:topicModel.hits.stringValue forState:UIControlStateNormal];
    [self.commentBtn setTitle:topicModel.replies.stringValue forState:UIControlStateNormal];
}

#pragma mark - lazy

- (JSFormTopicStatusButton *)readCountBtn {
    if (!_readCountBtn) {
        _readCountBtn = [[JSFormTopicStatusButton alloc] init];
        [_readCountBtn setImage:[UIImage imageNamed:@"read"] forState:UIControlStateNormal];
    }
    return _readCountBtn;
}

- (JSFormTopicStatusButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[JSFormTopicStatusButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    }
    return _commentBtn;
}

@end
