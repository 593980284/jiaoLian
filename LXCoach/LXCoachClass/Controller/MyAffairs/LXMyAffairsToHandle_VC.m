//
//  LXMyAffairsToHandle_VC.m
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXMyAffairsToHandle_VC.h"
#import "LXAffairsHandleSessionTask.h"
#import "LXAffairsDateSessionTask.h"
#import "LXMineModel.h"
#import "LXHadleCalendarView.h"
#import "LXHandleCell.h"
#import "LXAffairsHandleModel.h"
#import "LXCyhCalenbardate.h"
#import "LXAffairsDateModel.h"
@interface LXMyAffairsToHandle_VC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LXAffairsHandleSessionTask *handleTask;
@property (nonatomic, strong) LXAffairsDateSessionTask *dateTask;
@property (nonatomic, strong) LXHadleCalendarView *topDateView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LXMyAffairsToHandle_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topDateView];
    // Do any additional setup after loading the view.
}

-(void)loadLXMyAffairsToHandleData{
    [self.dateTask lxReuqestWithCompletionBlock:^(LXAffairsDateResponseObject * _Nonnull responseModel) {
        if (responseModel.flg == 1) {
            NSArray *dateArray = responseModel.data.list;
            for (LXAffairsDateModel *dateModel in dateArray) {
                // 1.1将时间转位时间戳
                // 1. 算出今天星期几
                NSDate *currentDate = [LXCyhCalenbardate timeSwitchDate:dateModel.date andFormatter:@"YYYY-MM-dd"];
                // 1.2根据时间戳来得到今天星期几
                NSString *weakDay = [LXCyhCalenbardate weekday:currentDate];
                NSString *str = [weakDay substringFromIndex:weakDay.length-1];
                dateModel.week = str;
                // 2. 得出是多少号
                dateModel.oneDate = [LXCyhCalenbardate obtainDateDay:dateModel.date];
            }
            self.topDateView.dataArr = dateArray;
        }
    }];
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kIdentifier = @"LXHandleCell";
    LXHandleCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (!cell) {
        cell = [[LXHandleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    LXAffairsHandleModel *courseListModel = self.dataArray[indexPath.row];
//    LXCourseDetailController *courseDetailController = [[LXCourseDetailController alloc]init];
//    courseDetailController.appointmentId = courseListModel.appointmentId;
//    courseDetailController.cheekPageOption = 1;
//    [[LXNavigationManager lx_currentNavigationController] pushViewController:courseDetailController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - getter
- (LXHadleCalendarView *)topDateView {
    if (!_topDateView) {
        _topDateView = [[LXHadleCalendarView alloc] init];
        _topDateView.frame = CGRectMake(0, 0, self.view.width, 118);
        [_topDateView setCollectionCellDidSelectBlock:^(NSInteger index) {
            
        }];
    }
    return _topDateView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topDateView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CGRectGetHeight(self.topDateView.frame)) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(LXAffairsHandleSessionTask *)handleTask{
    if (!_handleTask) {
        _handleTask = [LXAffairsHandleSessionTask new];
        LXMineModel *model = [LXCacheManager objectForKey:@"LXMineModel"];
        _handleTask.certNo = model.certNo;
    }
    return _handleTask;
}
-(LXAffairsDateSessionTask *)dateTask{
    if (!_dateTask) {
        _dateTask = [LXAffairsDateSessionTask new];
        LXMineModel *model = [LXCacheManager objectForKey:@"LXMineModel"];
        _dateTask.certNo = model.certNo;
    }
    return _dateTask;
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
