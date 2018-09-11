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
#import "LXCyhCalenbarview.h"

@interface LXCourseSubView()<UITableViewDelegate,UITableViewDataSource,LXGetdataStringDelegate>
@property (nonatomic ,strong) LXCyhCalenbarview *cyhcalenbar;
@property (nonatomic, strong) UITableView *tableView;
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
    self.tableView.height = CGRectGetHeight(self.frame)-CGRectGetHeight(self.cyhcalenbar.daycalenbarview.frame);
}

- (void)createUI {
    [self addSubview:self.cyhcalenbar.daycalenbarview];
    [self addSubview:self.tableView];
}

#pragma mark - setter
- (void)setDataSourse:(NSArray<LXCourseListModel *> *)dataSourse {
    _dataSourse = dataSourse;
    [self.tableView reloadData];
}

#pragma mark - LXGetdataStringDelegate
/**
 *  获取当前或选择日期
 *
 *  @param datestring 日期字符串
 */
- (void)getDatestring:(NSString *)datestring {
    
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kIdentifier = @"LXCourseCell";
    LXCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (!cell) {
        cell = [[LXCourseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
    }
    cell.courseListModel = [LXCourseListModel new];
    [cell layoutIfNeeded];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXCourseListModel *courseListModel = self.dataSourse[indexPath.row];
    LXCourseDetailController *courseDetailController = [[LXCourseDetailController alloc]init];
    courseDetailController.courseListModel = courseListModel;
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

#pragma mark - getter
- (LXCyhCalenbarview *)cyhcalenbar {
    if (!_cyhcalenbar) {
        //初始化，如果日历小于120.0的高度将默认为120.0高度
        _cyhcalenbar = [[LXCyhCalenbarview alloc] initD_calenbarframe:CGRectMake(0, 0, self.width, 120)];
        _cyhcalenbar.daydelegate = self;
        //注册使用
        [_cyhcalenbar daycalenbarviewNSdate];
        //日历背景颜色
        _cyhcalenbar.calenbarBGcolor = [UIColor whiteColor];
        //当天日期圆点颜色
        _cyhcalenbar.todayNumBGcolor = [UIColor colorWithHexString:@"#309CF5"];
        //被选中的日期圆点颜色
        _cyhcalenbar.SelecNumBGcolor = [UIColor colorWithHexString:@"#309CF5"];
        //当天日期数字颜色
        _cyhcalenbar.todaytextColor = [UIColor colorWithRed:235.0/255.0 green:104.0/255.0 blue:89.0/255.0 alpha:1.0];
    }
    return _cyhcalenbar;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cyhcalenbar.daycalenbarview.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetHeight(self.cyhcalenbar.daycalenbarview.frame)) style:UITableViewStyleGrouped];
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
