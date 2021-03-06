//
//  LXStudentController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentController.h"
#import "LXCommonNavView.h"
#import "LXStudentSubView.h"
#import "LXStudentSubViewCell.h"
#import "LXFindMyStudentSessionTask.h"
#import "LXMineModel.h"
#import "LXMyStudentListModel.h"
#import "LXLoginController.h"
#import "LXNavigationController.h"
#import "LXStudentDetail_VC.h"

static NSString *studentList_Identify = @"LXStudentSubViewCell";

@interface LXStudentController ()<LXCommonNavViewDelegate,LXStudentSubViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXStudentSubView *subView;
@property (nonatomic, strong) NSArray *dataSourceArr;
@property (nonatomic, strong) LXFindMyStudentSessionTask *studentDataController;
@end

@implementation LXStudentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self requestStudentList];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestStudentList];
}

#pragma mark - request
- (void)requestStudentList {
    [self.studentDataController lxReuqestFindMyStudentWithCompletionBlock:^(LXFindMyStudentResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            self.dataSourceArr = [NSArray yy_modelArrayWithClass:[LXMyStudentListModel class] json:[[responseModel.data objectForKey:@"list"] yy_modelToJSONData]];
            [self.subView reloadTableView];
        }else if (responseModel.flg == -2) {
            // 用户未登录
            LXLoginController *loginVC = [[LXLoginController alloc]init];
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            LXNavigationController *navc = [[LXNavigationController alloc] initWithRootViewController:loginVC];
            window.rootViewController = navc;
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

#pragma mark - private
- (void)callMobile:(NSString *)mobile {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",mobile];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
#pragma mark - LXStudentSubViewDelegate
- (NSInteger)lx_myStudentListTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}
- (UITableViewCell *)lx_myStudentListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXStudentSubViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentList_Identify];
    if (cell == nil) {
        cell = [[LXStudentSubViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:studentList_Identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LXMyStudentListModel *model = self.dataSourceArr[indexPath.row];
    [cell configStudentListModel:model];
    @weakify(self)
    [cell setCallMobileBlock:^{
        @strongify(self)
        [self callMobile:model.mobile];
    }];
    return cell;
}
- (CGFloat)lx_myStudentListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 15 + 94 * kAutoSizeScaleX;
}
- (void)lx_myStudentListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LXStudentDetail_VC *studentDetailVC = [[LXStudentDetail_VC alloc] init];
    LXMyStudentListModel *model = self.dataSourceArr[indexPath.row];
    studentDetailVC.headerModel = model;
    studentDetailVC.cerNoState = YES;
    [self.navigationController pushViewController:studentDetailVC animated:YES];
}
#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc]initWithTitle:@"我的学员"];
    }
    return _navView;
}
- (LXStudentSubView *)subView {
    if (!_subView) {
        _subView = [[LXStudentSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-(CGRectGetHeight(self.navView.frame) +CGRectGetHeight(self.tabBarController.tabBar.frame)));
        _subView.studentSubViewDelegate = self;
    }
    return _subView;
}

- (LXFindMyStudentSessionTask *)studentDataController {
    if (!_studentDataController) {
        LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
        _studentDataController = [[LXFindMyStudentSessionTask alloc] init];
        _studentDataController.certNo = mineModel.certNo;
        _studentDataController.rows = 500;
        _studentDataController.page = 1;
    }
    return _studentDataController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
