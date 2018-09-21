//
//  LXMessgaeListController.m
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMessgaeListController.h"
#import "LXMessageListCell.h"
#import "LXFindCoachMsgModel.h"
#import "LXMessageDataController.h"
#import "LXFindSingleCoachMsgSessionTask.h"
#import "LXFindSingleCoachMsgModel.h"
#import "LXCourseDetailController.h"

static NSString *messageList_Identify = @"LXMessageListCell";

@interface LXMessgaeListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXMessageDataController *dataController;
@end

@implementation LXMessgaeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
#ifdef __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#endif
}

#pragma mark - request
- (void)requestMsgIdToSubject:(NSString *)msgId {
    [self.dataController lxReuqestFindSingleCoachMsgWithMsgId:msgId completionBlock:^(LXFindSingleCoachMsgResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            LXCourseDetailController *detaileVC = [[LXCourseDetailController alloc] init];
            detaileVC.appointmentId = [responseModel.data.appointmentId integerValue];
            [self.navigationController pushViewController:detaileVC animated:YES];
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:messageList_Identify];
    if (cell == nil) {
        cell = [[LXMessageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageList_Identify];
    }
    [cell configMessagListValue:self.dataArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LXFindCoachMsgModel *msgModel = self.dataArr[indexPath.row];
    if ([msgModel.msgType integerValue] == 3) {
        // 教学提醒消息
        // 1. 根据msgId 跳转到课程详情
        [self requestMsgIdToSubject:[NSString stringWithFormat:@"%ld", msgModel.msgId]];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.003;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
#pragma mark - setter
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self.tableView reloadData];
}
#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat navHeight = LXNavigationViewHeight+CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
        CGFloat tabBarHeight = CGRectGetHeight(self.tabBarController.tabBar.frame);
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-(navHeight+45+tabBarHeight));
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (LXMessageDataController *)dataController {
    if (!_dataController) {
        _dataController = [[LXMessageDataController alloc] init];
    }
    return _dataController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
