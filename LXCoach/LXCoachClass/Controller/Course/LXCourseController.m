//
//  LXCourseController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseController.h"
#import "LXCommonNavView.h"
#import "LXCourseSubView.h"
#import "LXCourseDataController.h"
#import "LXFindMyCouseDateListSessionTask.h"
#import "LXFindMyCouseListByDateSessionTask.h"
#import "LXMineModel.h"
#import "LXCourseFindDateListModel.h"
#import "LXCourseListModel.h"

@interface LXCourseController ()
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXCourseSubView *courseSubView;
@property (nonatomic, strong) LXCourseDataController *dataController;
@property (nonatomic, strong) LXMineModel *mineModel;
/// 日期Arr
@property (nonatomic, strong) NSArray *dateSourceArr;
/// 对应的课程列表Arr
@property (nonatomic, strong) NSArray *courseListArr;
@end

@implementation LXCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestFindMyCouseDateList];
    [self createUI];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    self.courseSubView.height = kScreenHeight-self.navView.height-CGRectGetHeight(self.tabBarController.tabBar.frame)-self.view.safeAreaInsets.bottom;
}

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.courseSubView];
    if (@available(iOS 11, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - request
//  查询我的课程日期列表
- (void)requestFindMyCouseDateList {
    [self.dataController lxReuqestFindMyCouseDateListWithCertNo:self.mineModel.certNo completionBlock:^(LXFindMyCouseDateListResponseObject *responseModel) {
        if (responseModel.flg == 1) { //LXCourseFindDateListModel
            self.dateSourceArr = [NSArray yy_modelArrayWithClass:[LXCourseFindDateListModel class] json:[[responseModel.data objectForKey:@"list"] yy_modelToJSONData]];
            LXCourseFindDateListModel * model = [self.dateSourceArr firstObject];
            [self requestToDateFindCouseListCerNo:self.mineModel.certNo andDate:@"2018-09-17"];
        }
    }];
    
}
// 我的课程----根据日期查询排课
- (void)requestToDateFindCouseListCerNo:(NSString *)cerNo andDate:(NSString *)date {
    [self.dataController lxReuqestFindMyCouseListByDateWithCertNo:cerNo andDate:date completionBlock:^(LXFindMyCouseListByDateResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            self.courseListArr = [NSArray yy_modelArrayWithClass:[LXCourseListModel class] json:[[responseModel.data objectForKey:@"list"] yy_modelToJSONData]];
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"我的课程"];
    }
    return _navView;
}

- (LXCourseSubView *)courseSubView {
    if (!_courseSubView) {
        _courseSubView = [[LXCourseSubView alloc]initWithFrame:CGRectMake(0, self.navView.height, kScreenWidth, kScreenHeight-self.navView.height-CGRectGetHeight(self.tabBarController.tabBar.frame))];
    }
    return _courseSubView;
}
- (LXCourseDataController *)dataController {
    if (!_dataController) {
        _dataController = [[LXCourseDataController alloc] init];
    }
    return _dataController;
}
- (LXMineModel *)mineModel {
    if (!_mineModel) {
        _mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    }
    return _mineModel;
}
@end
