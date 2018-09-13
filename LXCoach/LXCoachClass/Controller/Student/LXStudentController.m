//
//  LXStudentController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentController.h"
#import "LXStudentDetailController.h"
#import "LXCommonNavView.h"
#import "LXStudentSubView.h"
#import "LXStudentSubViewCell.h"
#import "LXStudentDataController.h"
#import "LXFindMyStudentSessionTask.h"
#import "LXMineModel.h"
#import "LXMyStudentListModel.h"

static NSString *studentList_Identify = @"LXStudentSubViewCell";

@interface LXStudentController ()<LXCommonNavViewDelegate,LXStudentSubViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXStudentSubView *subView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) LXStudentDataController *studentDataController;
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

#pragma mark - request
- (void)requestStudentList {
    LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    [self.studentDataController lxReuqestFindMyStudentListWithCertNo:mineModel.certNo completionBlock:^(LXFindMyStudentResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            self.dataSourceArr = [responseModel.data objectForKey:@"list"];
            [self.subView reloadTableView];
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
    LXStudentDetailController *studentDetailVC = [[LXStudentDetailController alloc] init];
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
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [[NSMutableArray alloc] init];
    }
    return _dataSourceArr;
}
- (LXStudentDataController *)studentDataController {
    if (!_studentDataController) {
        _studentDataController = [[LXStudentDataController alloc] init];
    }
    return _studentDataController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
