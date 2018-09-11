//
//  JSFormTopicCell.m
//  MajorForum
//
//  Created by ecg on 2018/9/11.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSFormTopicCell.h"


@interface JSFormTopicCell ()

@property (nonatomic,strong) JSFormTopicContentView   *contentTopAreaView;
@property (nonatomic,strong) JSFormTopicStatusBarView *statusBarView;

@end

@implementation JSFormTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpContentView];
    }
    return self;
}

- (void)setTopicModel:(JSFormTopic *)topicModel {
    _topicModel = topicModel;
    self.contentTopAreaView.topicModel = topicModel;
    self.statusBarView.topicModel = topicModel;
}

- (void)setUpContentView {
    
    self.contentTopAreaView = [[JSFormTopicContentView alloc] init];
    self.statusBarView      = [[JSFormTopicStatusBarView alloc] init];
    
    [self.contentView addSubview:self.contentTopAreaView];
    [self.contentView addSubview:self.statusBarView];
    
    [self.contentTopAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(100);
    }];
    [self.statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTopAreaView.mas_bottom);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(25);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
