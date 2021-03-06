//
//  LXCoureListSubViewController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/7.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCoureListSubViewController.h"
#import "LXCourseDetailController.h"
#import "LXCourseListCell.h"
#import "LXFindCourseRecordModel.h"
#import "LXCourseListModel.h"

static NSString *courseList_Identify = @"LXCourseListCell";

@interface LXCoureListSubViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LXCoureListSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.tableView];
    
#ifdef __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#endif
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:courseList_Identify];
    if (cell == nil) {
        cell = [[LXCourseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseList_Identify];
    }
    [cell configCellValue:self.dataArr[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LXFindCourseRecordModel *recordModel = self.dataArr[indexPath.row];
    LXCourseDetailController *detailVC = [[LXCourseDetailController alloc] init];
    detailVC.appointmentId = [recordModel.appointmentId integerValue];
//    detailVC.cheekPageOption = 2;
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-(navHeight+45)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
