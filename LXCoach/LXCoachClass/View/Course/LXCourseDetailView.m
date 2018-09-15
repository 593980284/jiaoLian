
//  LXCourseDetailView.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseDetailView.h"
#import "LXCourseDetailHeadView.h"
#import "LXCourseDetailCell.h"
#import "LXCourseDetailModel.h"
#import "LXCourseListModel.h"
#import "LXCourseEvaluateController.h"
#import "LXNavigationManager.h"

@interface LXCourseDetailView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCourseDetailHeadView *headView;

@end

@implementation LXCourseDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.height = CGRectGetHeight(self.frame)- CGRectGetHeight(self.headView.frame);
}

- (void)createUI {
    [self addSubview:self.headView];
    [self addSubview:self.tableView];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.courseDetailArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kIdentifier = @"LXCourseDetailCell";
    LXCourseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (!cell) {
        cell = [[LXCourseDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
    }
    cell.courseStudentModel = self.courseDetailArr[indexPath.row];
    cell.optionStartNumber = 4;
    @weakify(self);
    [cell setStudentOperationBtn1Block:^{
        @strongify(self);
        [self.delegate lx_button1Click:indexPath];
    }];
    [cell setStudentOperationBtn2Block:^{
        @strongify(self);
        [self.delegate lx_button2Click:indexPath];
    }];
    
    [cell layoutIfNeeded];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isEvaluate == 0) {
        // 去评价
        
    }else {
        // 已经评价
        
    }
//    LXCourseListModel *courseListModel = self.dataSourse[indexPath.row];
    LXCourseEvaluateController *courseEvaluateController = [[LXCourseEvaluateController alloc]init];
//    courseDetailController.courseListModel = courseListModel;
    [[LXNavigationManager lx_currentNavigationController] pushViewController:courseEvaluateController animated:YES];
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
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - setter
- (void)setTopSubjectModel:(LXCourseListModel *)topSubjectModel {
    _topSubjectModel = topSubjectModel;
    self.headView.courseListModel = self.topSubjectModel;
}
- (void)setCourseDetailArr:(NSArray<LXCourseDetailModel *> *)courseDetailArr {
    _courseDetailArr = courseDetailArr;
    [self.tableView reloadData];
}
- (void)setIsEvaluate:(NSInteger)isEvaluate {
    _isEvaluate = isEvaluate;
}
#pragma mark - getter
- (LXCourseDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[LXCourseDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 135)];
    }
    return _headView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.headView.frame), CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)- CGRectGetHeight(self.headView.frame)) style:UITableViewStylePlain];
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
