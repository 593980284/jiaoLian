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
#import "LXCyhCalenbardate.h"
#import "LXLoginController.h"
#import "LXNavigationController.h"

@interface LXCourseController ()<LXCourseSubViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXCourseSubView *courseSubView;
@property (nonatomic, strong) LXCourseDataController *dataController;
@property (nonatomic, strong) LXMineModel *mineModel;
/// 日期Arr
@property (nonatomic, strong) NSMutableArray *dateSourceArr;
/// 对应的课程列表Arr
@property (nonatomic, strong) NSArray<LXCourseListModel *> *courseListArr;
@end

@implementation LXCourseController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestFindMyCouseDateList];
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
    self.dateSourceArr = [[NSMutableArray alloc] init];
    [self.dataController lxReuqestFindMyCouseDateListWithCertNo:self.mineModel.certNo completionBlock:^(LXFindMyCouseDateListResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            NSArray *listArr = [NSArray yy_modelArrayWithClass:[LXCourseFindDateListModel class] json:[[responseModel.data objectForKey:@"list"] yy_modelToJSONData]];
            for (NSInteger i = 0; i < listArr.count; i++) {
                LXCourseFindDateListModel *dateModel = listArr[i];
                if (i == 0) {
                    dateModel.firstIsOption = 1;
                }
                // 1. 算出今天星期几
                // 1.1将时间转位时间戳
                NSDate *currentDate = [LXCyhCalenbardate timeSwitchDate:dateModel.date andFormatter:@"YYYY-MM-dd"];
                // 1.2根据时间戳来得到今天星期几
                NSString *weakDay = [LXCyhCalenbardate weekday:currentDate];
                NSString *str = [weakDay substringFromIndex:weakDay.length-1];
                dateModel.week = str;
                // 2. 得出是多少号
                dateModel.oneDate = [LXCyhCalenbardate obtainDateDay:dateModel.date];
                // 3. 当前的年-月
                dateModel.yearAndMonth = [LXCyhCalenbardate obtainDateYearAndMonth:dateModel.date];
                [self.dateSourceArr addObject:dateModel];
            }
            
            self.courseSubView.dateArr = self.dateSourceArr;
            
            LXCourseFindDateListModel * model = [self.dateSourceArr firstObject];
            [self requestToDateFindCouseListCerNo:self.mineModel.certNo andDate:model.date];
            
        }else if (responseModel.flg == -2) {
            // 用户未登录
            LXLoginController *loginVC = [[LXLoginController alloc]init];
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            LXNavigationController *navc = [[LXNavigationController alloc] initWithRootViewController:loginVC];
            window.rootViewController = navc;
        }
    }];
    
}
// 我的课程----根据日期查询排课
- (void)requestToDateFindCouseListCerNo:(NSString *)cerNo andDate:(NSString *)date {
    [self.dataController lxReuqestFindMyCouseListByDateWithCertNo:cerNo andDate:date completionBlock:^(LXFindMyCouseListByDateResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            self.courseListArr = [NSArray yy_modelArrayWithClass:[LXCourseListModel class] json:[[responseModel.data objectForKey:@"list"] yy_modelToJSONData]];
            self.courseSubView.dataSourse = self.courseListArr;
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

#pragma mark - LXCourseSubViewDelegate
/**
 点击对应的日期加载对应的数据
 
 @param index 点击的下标
 */
- (void)lx_courseDidDateReloadSource:(NSInteger)index {
    LXCourseFindDateListModel * model = self.dateSourceArr[index];
    [self requestToDateFindCouseListCerNo:self.mineModel.certNo andDate:model.date];
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
        _courseSubView.delegate = self;
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
