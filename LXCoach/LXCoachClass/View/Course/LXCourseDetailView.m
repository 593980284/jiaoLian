
//  LXCourseDetailView.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseDetailView.h"
#import "LXNavigationManager.h"
#import "LXCourseDetailHeadView.h"
#import "LXCourseDetailCell.h"
#import "LXCourseDetailModel.h"
#import "LXCourseListModel.h"
#import "LXMyStudentListModel.h"
#import "LXStudentDetail_VC.h"
#import "LXCourseEvaluateController.h"
#import "LXCourseDataController.h"
#import "LXFindCoachEvaluationStudentSessionTask.h"
#import "LXSearchCourseRecordJudgeModel.h"
#import "NSObject+LXTimeExchangeDate.h"

@interface LXCourseDetailView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXCourseDetailHeadView *headView;
/// 评价button
@property (nonatomic, strong) UIButton *judgeButton;

@property (nonatomic, strong) LXCourseDataController *dataController;

@end

@implementation LXCourseDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.judgeButton.frame = CGRectMake(15, self.height-45-5, self.width-30, 45);
    if (self.courseDetailArr.count == 0 || self.cheekPageOption == 2) {
        self.tableView.height = CGRectGetHeight(self.frame)- CGRectGetHeight(self.headView.frame);
    }else {
        self.tableView.height = CGRectGetHeight(self.frame)- CGRectGetHeight(self.headView.frame)-CGRectGetHeight(self.judgeButton.frame)-10;
    }
    
}

- (void)createUI {
    [self addSubview:self.headView];
    [self addSubview:self.judgeButton];
    [self addSubview:self.tableView];
}

#pragma mark - Event
/// 课程评价
- (void)judgeButtonAction:(UIButton *)button {
    if (self.isEvaluate == 0) {
        NSString * periodTime =  self.topSubjectModel.periodTime;
        NSArray *timeArray = [periodTime componentsSeparatedByString:@" "];
        NSArray *ourArray = [[timeArray lastObject] componentsSeparatedByString:@"-"];
        NSString *lastTimeString = [NSString stringWithFormat:@"%@ %@:00",[timeArray firstObject],[ourArray lastObject]];
        // 后台返回时间段 - 时间戳
        NSInteger backTimeSp = [NSObject exchangeTimeSwitchTimeStamp:@"YYYY-MM-dd hh:mm:ss" andFormatter:lastTimeString];
        // 当前时间戳 1539342000
        NSInteger currentTimeSp = [NSObject currentTimeStamp]; //1539332876
        if (backTimeSp >= currentTimeSp) {
            [self makeToast:@"请在课程结束后评价"];
        }else {
            // 去评价
            LXCourseEvaluateController *courseEvaluateController = [[LXCourseEvaluateController alloc]init];
            courseEvaluateController.studentListArr = self.courseDetailArr;
            courseEvaluateController.topSubjectModel = self.topSubjectModel;
            courseEvaluateController.isEvaluate = self.isEvaluate;
            [[LXNavigationManager lx_currentNavigationController] pushViewController:courseEvaluateController animated:YES];
        }
        
        
    }
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
    LXCourseToStudentModel *detaileModel = self.courseDetailArr[indexPath.row];
    cell.courseStudentModel = detaileModel;
    cell.optionStartNumber = [detaileModel.studentScore integerValue] / 2;
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
    if (self.cheekPageOption == 1) {
        // 跳转去学员详情
        LXCourseToStudentModel *model = self.courseDetailArr[indexPath.row];
        LXMyStudentListModel *studentModel = [[LXMyStudentListModel alloc] init];
        studentModel.studentId = model.studentId;
        studentModel.studentName = model.studentName;
        studentModel.studentPhoto = model.studentPhoto;
        studentModel.mobile = model.mobile;
        studentModel.subjectName = model.subjectName;
        LXStudentDetail_VC *detailVC = [[LXStudentDetail_VC alloc] init];
        detailVC.headerModel = studentModel;
        detailVC.cerNoState = NO;
        [[LXNavigationManager lx_currentNavigationController] pushViewController:detailVC animated:YES];
    }else if (self.cheekPageOption == 2) {
        // 查看评价
        // 1. 请求数据是否有对应的评价
        LXCourseToStudentModel *model = self.courseDetailArr[indexPath.row];
        [self.dataController lxReuqestFindCoachEvaluationStudentWithCourseRecordId:[NSString stringWithFormat:@"%ld",model.courseRecordId] completionBlock:^(LXFindCoachEvaluationStudentResponseObject *responseModel) {
            if (responseModel.flg == 1) {
                if (responseModel.data.studentScore==0 && [responseModel.data.studentEvaluationContent isEqualToString:@""]) {
                    // 1.1 没有评价 --- 去评价
                    LXCourseEvaluateController *courseEvaluateController = [[LXCourseEvaluateController alloc]init];
                    courseEvaluateController.topSubjectModel = self.topSubjectModel;
                    courseEvaluateController.courseJudgeType = 1;
                    courseEvaluateController.studentName = model.studentName;
                    courseEvaluateController.courseRecordId = model.courseRecordId;
                    [[LXNavigationManager lx_currentNavigationController] pushViewController:courseEvaluateController animated:YES];
                } else {
                    // 1.2 有评价 ---查看评价
                    LXCourseEvaluateController *courseEvaluateController = [[LXCourseEvaluateController alloc]init];
                    courseEvaluateController.topSubjectModel = self.topSubjectModel;
                    courseEvaluateController.courseJudgeType = 2;
                    responseModel.data.studentName = model.studentName;
                    courseEvaluateController.readCourseRecordModel = responseModel.data;
                    [[LXNavigationManager lx_currentNavigationController] pushViewController:courseEvaluateController animated:YES];
                }
            }
        }];
    }
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
- (void)setTopSubjectModel:(LXCourseDetailModel *)topSubjectModel {
    _topSubjectModel = topSubjectModel;
    self.headView.courseListModel = self.topSubjectModel;
}
- (void)setCourseDetailArr:(NSArray<LXCourseToStudentModel *> *)courseDetailArr {
    _courseDetailArr = courseDetailArr;
    [self.tableView reloadData];
}
- (void)setIsEvaluate:(NSInteger)isEvaluate {
    _isEvaluate = isEvaluate;
    if (self.isEvaluate == 0) {
        self.judgeButton.hidden = NO;
        [self.judgeButton setTitle:@"课程评价" forState:UIControlStateNormal];
        self.tableView.height = self.tableView.height = CGRectGetHeight(self.frame)- CGRectGetHeight(self.headView.frame)-CGRectGetHeight(self.judgeButton.frame)-10;
    }else if (self.isEvaluate == 1){
        self.judgeButton.hidden = YES;
        self.tableView.height = self.tableView.height = CGRectGetHeight(self.frame)- CGRectGetHeight(self.headView.frame);
    }
}
- (void)setCheekPageOption:(NSInteger)cheekPageOption {
    _cheekPageOption = cheekPageOption;
    if (self.cheekPageOption == 2) {
        self.tableView.height = self.tableView.height = CGRectGetHeight(self.frame)- CGRectGetHeight(self.headView.frame);
    }
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
- (UIButton *)judgeButton {
    if (!_judgeButton) {
        _judgeButton = [[UIButton alloc] init];
        [_judgeButton setTitle:@"课程评价" forState:UIControlStateNormal];
        [_judgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_judgeButton setBackgroundColor:[UIColor colorWithHexString:@"#309CF5"]];
        _judgeButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _judgeButton.layer.cornerRadius = 5;
        [_judgeButton addTarget:self action:@selector(judgeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _judgeButton;
}
- (LXCourseDataController *)dataController {
    if (!_dataController) {
        _dataController = [[LXCourseDataController alloc] init];
    }
    return _dataController;
}
@end
