//
//  LXCourseDetailController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseDetailController.h"
#import "LXCommonNavView.h"
#import "LXCourseDetailView.h"
#import "LXCourseListModel.h"
#import "LXCourseDetailModel.h"
#import "LXCourseDataController.h"
#import "LXFindMyCouseDetailListSessionTask.h"
#import "LXMyCoachAttendanceStudentSessionTask.h"

@interface LXCourseDetailController ()<LXCommonNavViewDelegate,LXCourseDetailViewDelegate>

@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXCourseDetailView *courseDetailView;
@property (nonatomic, strong) LXCourseDataController *dataController;
/// 对应科目的课程列表
@property (nonatomic, strong) NSArray <LXCourseToStudentModel *> *courceListArr;
@end

@implementation LXCourseDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestMyCouseDetailList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self requestMyCouseDetailList];
    [self createUI];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.courseDetailView.height = kScreenHeight-CGRectGetHeight(self.navView.frame)-self.view.safeAreaInsets.bottom;
}

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.courseDetailView];
    
    if (@available(iOS 11, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma mark - request
// 获取对应科目的学员列表
- (void)requestMyCouseDetailList {
    @weakify(self);
    [self.dataController lxReuqestFindMyCouseDetailListWithAppointmentId:[NSString stringWithFormat:@"%ld",(long)self.appointmentId] completionBlock:^(LXFindMyCouseDetailListResponseObject *responseModel) {
        @strongify(self);
        if (responseModel.flg == 1) {
            self.courseDetailView.topSubjectModel = responseModel.data;
            self.courseDetailView.courseDetailArr = responseModel.data.list;
            self.courceListArr = [NSArray arrayWithArray:responseModel.data.list];
//            self.courseDetailView.isEvaluate = responseModel.data.isEvaluate;
        }
    }];
}

#pragma mark - delegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - LXCourseDetailViewDelegate
- (void)lx_button1Click:(NSIndexPath *)indexPath {
    // 缺勤 3
    LXCourseToStudentModel *model = self.courceListArr[indexPath.row];
    [self.dataController lxReuqestMyCoachAttendanceStudentWithCourseRecordId:[NSNumber numberWithInteger:model.courseRecordId] andStatus:[NSNumber numberWithInteger:3] completionBlock:^(LXMyCoachAttendanceStudentResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            [self requestMyCouseDetailList];
            [self.view makeToast:responseModel.msg];
        }
    }];
}

- (void)lx_button2Click:(NSIndexPath *)indexPath {
    // 已到 学员点击签到 2;  学员未点击签到 5;
    LXCourseToStudentModel *model = self.courceListArr[indexPath.row];
    NSInteger status = 0;
    if (model.status == 1) {
        // 学员点击了签到
        status = 2;
    }else if (model.status == 4) {
        // 学员未点击签到
        status = 5;
    }
    [self.dataController lxReuqestMyCoachAttendanceStudentWithCourseRecordId:[NSNumber numberWithInteger:model.courseRecordId] andStatus:[NSNumber numberWithInteger:status] completionBlock:^(LXMyCoachAttendanceStudentResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            [self requestMyCouseDetailList];
            [self.view makeToast:responseModel.msg];
        }
    }];
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"课程详情"];
        _navView.showBackButton = YES;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
        _navView.delegate = self;
    }
    return _navView;
}
- (LXCourseDetailView *)courseDetailView {
    if (!_courseDetailView) {
        _courseDetailView = [[LXCourseDetailView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame))];
        _courseDetailView.delegate = self;
//        _courseDetailView.cheekPageOption = self.cheekPageOption;
    }
    return _courseDetailView;
}
- (LXCourseDataController *)dataController {
    if (!_dataController) {
        _dataController = [[LXCourseDataController alloc] init];
    }
    return _dataController;
}
@end
