//
//  LXCourseSubView.m
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseSubView.h"
#import "LXCourseCell.h"
#import "LXCourseListModel.h"
#import "LXCourseDetailController.h"
#import "LXNavigationManager.h"
#import "LXCalendarView.h"
#import "LXCourseFindDateListModel.h"

@interface LXCourseSubView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCalendarView *topDateView;
@end

@implementation LXCourseSubView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.height = CGRectGetHeight(self.frame)-CGRectGetHeight(self.topDateView.frame);
}

- (void)createUI {
    [self addSubview:self.tableView];
    [self addSubview:self.topDateView];
    @weakify(self);
    [self.topDateView setCollectionCellDidSelectBlock:^(NSInteger index) {
        @strongify(self);
        [self.delegate lx_courseDidDateReloadSource:index];
    }];
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourse.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kIdentifier = @"LXCourseCell";
    LXCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (!cell) {
        cell = [[LXCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
    }
    
    cell.courseListModel = self.dataSourse[indexPath.row];
    [cell layoutIfNeeded];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LXCourseListModel *courseListModel = self.dataSourse[indexPath.row];
    LXCourseDetailController *courseDetailController = [[LXCourseDetailController alloc]init];
    courseDetailController.appointmentId = courseListModel.appointmentId;
    courseDetailController.cheekPageOption = 1;
    [[LXNavigationManager lx_currentNavigationController] pushViewController:courseDetailController animated:YES];
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
#pragma mark - setter 
- (void)setDateArr:(NSArray<LXCourseFindDateListModel *> *)dateArr {
    _dateArr = dateArr;
    self.topDateView.dataArr = [[NSMutableArray alloc] initWithArray:self.dateArr];
}
- (void)setDataSourse:(NSArray<LXCourseListModel *> *)dataSourse {
    _dataSourse = dataSourse;
    [self.tableView reloadData];
}

#pragma mark - getter
- (LXCalendarView *)topDateView {
    if (!_topDateView) {
        _topDateView = [[LXCalendarView alloc] init];
        _topDateView.frame = CGRectMake(0, 0, self.width, 118);
    }
    return _topDateView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topDateView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.topDateView.frame)) style:UITableViewStyleGrouped];
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

@end
