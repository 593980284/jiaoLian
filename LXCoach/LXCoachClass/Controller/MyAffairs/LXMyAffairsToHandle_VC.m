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
#import "LXCourseDataController.h"
#import "LXMineModel.h"

#import "LXHadleCalendarView.h"
#import "LXHandleCell.h"

#import "LXCyhCalenbardate.h"
#import "LXMyCoachAttendanceStudentSessionTask.h"
@interface LXMyAffairsToHandle_VC ()<UITableViewDelegate,UITableViewDataSource,LXHandleCellDelegate>
@property (nonatomic, strong) LXAffairsHandleSessionTask *handleTask;
@property (nonatomic, strong) LXAffairsDateSessionTask *dateTask;
@property (nonatomic, strong) LXHadleCalendarView *topDateView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) LXCourseDataController *dataController;
@end

@implementation LXMyAffairsToHandle_VC{
    LXAffairsDateModel *_selectedDateModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topDateView];
    @weakify(self);
    [_topDateView setCollectionCellDidSelectBlock:^(LXAffairsDateModel *model) {
        @strongify(self);
        [self loadLXMyAffairsToHandleWithModel:model];
    }];
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

- (void)loadLXMyAffairsToHandleWithModel:(LXAffairsDateModel *)model{
    _selectedDateModel = model;
    self.handleTask.date = model.date;
    [self.handleTask lxReuqestWithCompletionBlock:^(LXAffairsHandleResponseObject * _Nonnull responseModel) {
        if (responseModel.flg == 1) {
            self.dataArray = responseModel.data.list;
            [self.tableView reloadData];
        }
    }];
}

- (void)cellActionWithModel:(LXAffairsHandleSSlist *)model andType:(NSInteger)type{
    if (type == 1) {
        // 缺勤 3
        [self.dataController lxReuqestMyCoachAttendanceStudentWithCourseRecordId:[NSNumber numberWithInteger:[model.courseRecordId integerValue]] andStatus:[NSNumber numberWithInteger:3] completionBlock:^(LXMyCoachAttendanceStudentResponseObject *responseModel) {
            if (responseModel.flg ==1) {
                [self.view makeToast:responseModel.msg];
                [self loadLXMyAffairsToHandleWithModel:self->_selectedDateModel];
            }
        }];
    }else{
        //已到 学员点击签到 2;  学员未点击签到 5;
        NSInteger status = 0;
        if ([model.status integerValue] == 1) {
            // 学员点击了签到
            status = 2;
        }else if ([model.status integerValue] == 4) {
            // 学员未点击签到
            status = 5;
        }
        [self.dataController lxReuqestMyCoachAttendanceStudentWithCourseRecordId:[NSNumber numberWithInteger:[model.courseRecordId integerValue]] andStatus:[NSNumber numberWithInteger:status] completionBlock:^(LXMyCoachAttendanceStudentResponseObject *responseModel) {
            if (responseModel.flg == 1) {
                [self loadLXMyAffairsToHandleWithModel:self->_selectedDateModel];
                [self.view makeToast:responseModel.msg];
            }
        }];
    }
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LXAffairsHandleList *model = _dataArray[section];
    return model.sslist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kIdentifier = @"LXHandleCell";
    LXHandleCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (!cell) {
        cell = [[LXHandleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
        cell.delegate = self;
    }
    LXAffairsHandleList *model = _dataArray[indexPath.section];
    [cell updateWithModel:model.sslist[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 126;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LXAffairsHandleList *model = _dataArray[section];
    UILabel *headerLabel = [UILabel new];
    headerLabel.text = model.shortPeriodTime;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = TEXT_COLOR_GRAY;
    headerLabel.font = TEXT_FONT(12);
    return headerLabel;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


#pragma mark - getter
- (LXHadleCalendarView *)topDateView {
    if (!_topDateView) {
        _topDateView = [[LXHadleCalendarView alloc] init];
        _topDateView.frame = CGRectMake(0, 0, self.view.width, 63);
    }
    return _topDateView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topDateView.frame), kScreenWidth, self.view.height-LXNavigationStatusBar -45-63 - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStyleGrouped];
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
- (LXCourseDataController *)dataController {
    if (!_dataController) {
        _dataController = [[LXCourseDataController alloc] init];
    }
    return _dataController;
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
