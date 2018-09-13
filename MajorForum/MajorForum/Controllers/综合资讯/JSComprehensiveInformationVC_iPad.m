//
//  JSComprehensiveInformationVC_iPad.m
//  MajorForum
//
//  Created by ShenYj on 2018/9/10.
//  Copyright © 2018年 ShenYj. All rights reserved.
//

#import "JSComprehensiveInformationVC_iPad.h"
#import "JSDetailViewController.h"
#import "JSNetworkTool+JSComprehensiveInformation.h"
#import "JSFormTopic.h"

static NSString * const kComprehensiveInformationVCCellReusedID = @"kComprehensiveInformationVCCellReusedID";

@interface JSComprehensiveInformationVC_iPad () <JSDetailViewControllerProtocol>

/** 新帖 */
@property (nonatomic,strong) NSArray <JSFormTopic *> *NewTopicDatas;
/** 精华 */
@property (nonatomic,strong) NSArray <JSFormTopic *> *EssentialTopicDatas;

/** 页码 */
@property (nonatomic,assign) NSInteger pageIdx;



@end

@implementation JSComprehensiveInformationVC_iPad

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ciType = ComprehensiveInformationTypeNewPosts;
    self.pageIdx = 1;
    //[self loadComprehensiveInformationNewDatas:YES];
}

- (void)headerWithRefreshingTarget {
    [self loadComprehensiveInformationNewDatas:YES];
}
- (void)footerWithRefreshingTarget {
    [self loadComprehensiveInformationNewDatas:NO];
}

/** 请求新帖数据 */
- (void)loadComprehensiveInformationNewDatas:(BOOL)flag {
    
    if (self.isLoading) {
        NSLog(@"正在加载数据中....");
        return;
    }
    if (flag) {
        self.pageIdx = 1;   // 下拉加载新帖
    } else {
        self.pageIdx++;     // 上拉加载更多
    }
    self.isLoading = YES;
    
    [[JSNetworkTool sharedNetworkToolManager] getComprehensiveInformationNewDatas:self.pageIdx FinishedBlock:^(id obj, NSError *error) {
        if (error != nil || obj == nil) {
            NSLog(@"请求失败-->!%@",error);
            [self endRefresh];
            return ;
        }
        NSLog(@"%@", [obj class]);
        NSArray *list = obj[@"list"];
        if ( !list ) {
            NSLog(@"数据异常");
            [self endRefresh];
            return;
        }
        if (list.count == 0) {
            NSLog(@"返回空");
            self.pageIdx--;
            [self endRefresh];
            return;
        }
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.NewTopicDatas];
        if (flag) {
            // 下拉插入前端
            [list enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JSFormTopic *model = [JSFormTopic yy_modelWithDictionary:obj];
                if (![self.NewTopicDatas containsObject:model]) NSLog(@"不包含: %@",model.topic_id);
                if (![tempArr containsObject:model]) [tempArr insertObject:model atIndex:0];
                @autoreleasepool {
                }
            }];
        } else {
            // 上拉加载后面
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                @autoreleasepool {
                    JSFormTopic *model = [JSFormTopic yy_modelWithDictionary:obj];
                    if (![self.NewTopicDatas containsObject:model]) [tempArr addObject:model];
                }
            }];
        }
        self.NewTopicDatas = tempArr.copy;
        [self.js_tableView reloadData];
        [self endRefresh];
    }];
}
/** 请求精华数据 */
- (void)loadComprehensiveInformationEssentialDatas:(BOOL)flag {
    [self.js_tableView reloadData];
}

- (void)setUpView {
    [self.js_tableView registerClass:[JSFormTopicCell class] forCellReuseIdentifier:kComprehensiveInformationVCCellReusedID];
}

#pragma mark -- JSDetailViewControllerProtocol

- (void)segmentValueChanged:(UISegmentedControl *)segment {
    
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.ciType = ComprehensiveInformationTypeNewPosts;
            [self loadComprehensiveInformationNewDatas:YES];
            break;
        case 1:
            self.ciType = ComprehensiveInformationTypeEssential;
            [self loadComprehensiveInformationEssentialDatas:YES];
            break;
        default:
            break;
    }
}

#pragma mark - table view dataScoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.ciType == ComprehensiveInformationTypeNewPosts) return self.NewTopicDatas.count;
    return self.EssentialTopicDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSFormTopic *topic = nil;
    if (self.ciType == ComprehensiveInformationTypeNewPosts) {
        topic = self.NewTopicDatas[indexPath.row];
    } else {
        topic = self.EssentialTopicDatas[indexPath.row];
    }
    JSFormTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:kComprehensiveInformationVCCellReusedID forIndexPath:indexPath];
    cell.topicModel = topic;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
