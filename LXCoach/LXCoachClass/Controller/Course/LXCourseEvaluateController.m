//
//  LXCourseEvaluateController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseEvaluateController.h"
#import "LXCommonNavView.h"
#import "LXCourseEvaluateView.h"
#import "LXCourseDataController.h"
#import "LXMyCoachEvaluationStudentsSessionTask.h"
#import "LXCoachEvaluationStudentSessionTask.h"
#import "LXAlterPromptView.h"

@interface LXCourseEvaluateController ()<LXCommonNavViewDelegate,LXCourseEvaluateViewDelegate,LXAlterPromptViewDelegate>

@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXCourseEvaluateView *subView;
@property (nonatomic, strong) LXCourseDataController *dataController;

/// 背景图
@property (nonatomic, strong) UIView *alterBgView;
@property (nonatomic, strong) LXAlterPromptView *promptView;

@end

@implementation LXCourseEvaluateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
}

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
    if (@available(iOS 11, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.view addSubview:self.alterBgView];
    if (self.isEvaluate == 0 || self.courseJudgeType == 1) {
        if (self.courseJudgeType == 2) {
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        [self.alterBgView addSubview:self.promptView];
        self.promptView.centerX = self.alterBgView.centerX;
        self.promptView.centerY = self.alterBgView.centerY;
        self.promptView.alterString = @"是否放弃本次评论？";
        
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - LXCourseEvaluateViewDelegate
/**
 提交评价
 
 @param courseRecordIds 约课记录id
 @param studentScores 课程评价分数
 @param studentEvaluationContents 课程评价内容
 */
- (void)lx_courseAssessSubmitCourseRecordIds:(NSMutableArray *)courseRecordIds andStudentScores:(NSMutableArray *)studentScores andStudentEvaluationContents:(NSMutableArray *)studentEvaluationContents {
    NSString *courseRecordIdsString;
    NSString *studentScoresString;
    NSString *studentEvaluationContentsString;
    if (self.studentListArr.count == 1) {
        courseRecordIdsString = [courseRecordIds firstObject];
        studentScoresString = [studentScores firstObject];
        studentEvaluationContentsString = [studentEvaluationContents firstObject];
    }else {
        courseRecordIdsString = [courseRecordIds componentsJoinedByString:@","];
        studentScoresString = [studentScores componentsJoinedByString:@","];
        studentEvaluationContentsString = [studentEvaluationContents componentsJoinedByString:@"~!~"];
    }
    [self.dataController lxReuqestMyCoachEvaluationStudentsWithCourseRecordIds:courseRecordIdsString andStudentScores:studentScoresString andStudentEvaluationContents:studentEvaluationContentsString completionBlock:^(LXMyCoachEvaluationStudentsResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

/**
 课程记录进入---单个课程评价
 
 @param studentScore 课程评价分数
 @param studentEvaluationContent 课程评价内容
 */
- (void)lx_singleCourseRecordSubmitStudentScore:(NSInteger)studentScore andStudentEvaluationContent:(NSString *)studentEvaluationContent {
    [self.dataController lxReuqestCoachEvaluationStudentWithCourseRecordId:[NSNumber numberWithInteger:self.courseRecordId] andStudentScore:[NSNumber numberWithInteger:studentScore] andStudentEvaluationContent:studentEvaluationContent completionBlock:^(LXCoachEvaluationStudentResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}
#pragma mark - LXAlterPromptViewDelegate
/// 取消按钮
- (void)lx_cancelClickButton {
    [self.alterBgView removeFromSuperview];
}

/// 确认按钮
- (void)lx_enterClickButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"课程评价"];
        _navView.showBackButton = YES;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
        _navView.delegate = self;
    }
    return _navView;
}
- (LXCourseEvaluateView *)subView {
    if (!_subView) {
        _subView = [[LXCourseEvaluateView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
        _subView.delegate = self;
        _subView.topSubjectModel = self.topSubjectModel;
        if (self.studentListArr) {
            _subView.courseListDetaileArr = self.studentListArr;
        }
        if (self.readCourseRecordModel) {
            _subView.readCourseRecordModel = self.readCourseRecordModel;
        }
        if (self.courseJudgeType) {
            _subView.courseJudgeType = self.courseJudgeType;
        }
    }
    return _subView;
}
- (LXCourseDataController *)dataController {
    if (!_dataController) {
        _dataController = [[LXCourseDataController alloc] init];
    }
    return _dataController;
}
- (UIView *)alterBgView {
    if (!_alterBgView) {
        _alterBgView = [[UIView alloc] init];
        _alterBgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _alterBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }
    return _alterBgView;
}
- (LXAlterPromptView *)promptView {
    if (!_promptView) {
        _promptView = [[LXAlterPromptView alloc] init];
        _promptView.frame = CGRectMake(73, 100, 230, 140);
        _promptView.delegate = self;
    }
    return _promptView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
