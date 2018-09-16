//
//  LXMineController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMineController.h"
#import "LXUserInfoDataController.h"
#import "LXUserInfoUrlSessionTask.h"
#import "LXCourceListController.h"
#import "LXMineMessageAlterController.h"
#import "LXAboutOursViewController.h"
#import "LXIntroMineController.h"
#import "LXCommonNavView.h"
#import "LXMineMainSubView.h"
#import "LXMineCell.h"
#import "LXMineModel.h"
#import "LXAlterPromptView.h"

static NSString *cell_Identify = @"LXMineCell";

@interface LXMineController ()<LXMineMainSubViewDelegate,LXAlterPromptViewDelegate>

@property (nonatomic, strong)LXCommonNavView *navView;
@property (nonatomic, strong)LXMineMainSubView *subView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) LXUserInfoDataController *infoDataController;
/// 背景图
@property (nonatomic, strong) UIView *alterBgView;
@property (nonatomic, strong) LXAlterPromptView *promptView;

@end

@implementation LXMineController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestUserInfoMessage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
    LXMineModel *mineModel =  [LXCacheManager objectForKey:@"LXMineModel"];
    [self.subView lx_updateMineMessage:mineModel];
}

#pragma mark - request
- (void)requestUserInfoMessage {
    LXMineModel *mineModel =  [LXCacheManager objectForKey:@"LXMineModel"];
    [self.infoDataController lxReuqestUserInfoWithCertNo:mineModel.certNo completionBlock:^(LXUserInfoResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            // 存储用户数据
            [LXCacheManager storeObject:responseModel.data forKey:@"LXMineModel"];
            [self.subView lx_updateMineMessage:responseModel.data];
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
    [LXCacheManager cleanCacheSize];
    [self.alterBgView removeFromSuperview];
    [self.view makeToast:@"清除成功"];
}

#pragma mark - LXMineMainSubViewDelegate
- (NSInteger)lx_numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)lx_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)lx_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXMineCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Identify];
    if (cell == nil) {
        cell = [[LXMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_Identify];
    }
    [cell mineCellValuation:self.dataSource[indexPath.section][indexPath.row]];
    return cell;
}
- (CGFloat)lx_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (CGFloat)lx_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)lx_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.02;
}
- (void)lx_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger clickType = [[self.dataSource[indexPath.section][indexPath.row] objectForKey:@"clickType"] integerValue];
    switch (clickType) {
        case LXMineSlectTypeCourseList:
        {
            // 课程记录
            LXCourceListController *courceListVC = [[LXCourceListController alloc] init];
            [self.navigationController pushViewController:courceListVC animated:YES];
        }
            break;
        case LXMineSlectTypeMineIntro:
        {
            // 个人简介
            LXIntroMineController *introVC = [[LXIntroMineController alloc] init];
            [self.navigationController pushViewController:introVC animated:YES];
        }
            break;
        case LXMineSlectTypeRefreshCache:
        {
            // 刷新缓存
            NSString *size = [LXCacheManager readCacheSize];
            if ([size integerValue] == 0) {
                [self.view makeToast:@"没有可清理的缓存数据"];
            }else {
                [self.view addSubview:self.alterBgView];
                [self.alterBgView addSubview:self.promptView];
                self.promptView.centerX = self.alterBgView.centerX;
                self.promptView.centerY = self.alterBgView.centerY;
                self.promptView.alterString = [NSString stringWithFormat:@"是否清除%@的缓存？",size];
            }
        }
            break;
        case LXMineSlectTypeCheckUpdate:
        {
            // 检查更新
            
        }
            break;
        case LXMineSlectTypeAboutOurs:
        {
            // 关于我们
            LXAboutOursViewController *aboutOursVC = [[LXAboutOursViewController alloc] init];
            [self.navigationController pushViewController:aboutOursVC animated:YES];
        }
            break;
        
            
       
    }
}
- (void)lx_clickHeaderAction {
    LXMineMessageAlterController *mineAlterVC = [[LXMineMessageAlterController alloc] init];
    [self.navigationController pushViewController:mineAlterVC animated:YES];
}
#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:@"我的"];
    }
    return _navView;
}
- (LXMineMainSubView *)subView {
    if (!_subView) {
        _subView = [[LXMineMainSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
        _subView.mainMineDelegate = self;
    }
    return _subView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LXMineMessageList" ofType:@"plist"];
        _dataSource = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    return _dataSource;
}
- (LXUserInfoDataController *)infoDataController {
    if (!_infoDataController) {
        _infoDataController = [[LXUserInfoDataController alloc] init];
    }
    return _infoDataController;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
