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

@end

@implementation JSComprehensiveInformationVC_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ciType = ComprehensiveInformationTypeNewPosts;
    [self loadComprehensiveInformationNewDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 请求新帖数据 */
- (void)loadComprehensiveInformationNewDatas {
    [[JSNetworkTool sharedNetworkToolManager] getComprehensiveInformationNewDatasFinishedBlock:^(id obj, NSError *error) {
        if (error != nil || obj == nil) {
            NSLog(@"请求失败-->!%@",error);
            return ;
        }
        NSLog(@"%@", obj);
        NSArray *list = obj[@"list"];
        if ( !list ) {
            NSLog(@"数据异常");
            return;
        }
        if (list.count == 0) {
            NSLog(@"返回空");
            
        }
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:list.count];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                JSFormTopic *model = [JSFormTopic yy_modelWithDictionary:obj];
                [tempArr addObject:model];
            }
        }];
        self.NewTopicDatas = tempArr.copy;
        [self.js_tableView reloadData];
    }];
}
/** 请求精华数据 */
- (void)loadComprehensiveInformationEssentialDatas {
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
            [self loadComprehensiveInformationNewDatas];
            break;
        case 1:
            self.ciType = ComprehensiveInformationTypeEssential;
            [self loadComprehensiveInformationEssentialDatas];
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
