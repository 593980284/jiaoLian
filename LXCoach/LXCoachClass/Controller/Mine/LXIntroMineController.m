//
//  LXIntroMineController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXIntroMineController.h"
#import "LXCommonNavView.h"
#import "LXIntroMineSubView.h"
#import "LXUserInfoDataController.h"
#import "LXSaveUserInfoUrlSessionTask.h"
#import "LXMineModel.h"
#import "LXAlterPromptView.h"

@interface LXIntroMineController ()<LXCommonNavViewDelegate,LXIntroMineSubViewDelegate,LXAlterPromptViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXIntroMineSubView *subView;
/// 背景图
@property (nonatomic, strong) UIView *alterBgView;
@property (nonatomic, strong) LXAlterPromptView  *alterView;
@property (nonatomic, strong) LXMineModel *mineModel;
@property (nonatomic, strong) LXUserInfoDataController *saveIntoDataController;

@end

@implementation LXIntroMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
}
#pragma mark - LXIntroMineSubViewDelegate
/**
 确认修改简介
 
 @param introMessage 修改后的简介
 */
- (void)lx_alterMineMessage:(NSString *)introMessage {
    [self.saveIntoDataController lxReuqestSaveUserInfoWithCertNo:self.mineModel.certNo present:introMessage completionBlock:^(LXSaveUserInfoResponseObject *responseModel) {
        [self.view makeToast:responseModel.msg];
        self.mineModel.present = introMessage;
        // 保存更新后的model
        [LXCacheManager storeObject:self.mineModel forKey:@"LXMineModel"];
    }];
}

#pragma mark - LXCommonNavViewDelegate

- (void)lx_clickLeftButton {
    if (![self.mineModel.present isEqualToString:self.subView.introDetaile.text]) {
        // 提示简介没有保存
        [self.view addSubview:self.alterBgView];
        [self.alterBgView addSubview:self.alterView];
        self.alterView.centerX = self.alterBgView.centerX;
        self.alterView.centerY = self.alterBgView.centerY;
        self.alterView.alterString = @"是否放弃个人简介的编辑？";
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
        _navView = [[LXCommonNavView alloc] initWithTitle:@"个人简介"];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (LXIntroMineSubView *)subView {
    if (!_subView) {
        _subView = [[LXIntroMineSubView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
        _subView.delegate = self;
    }
    return _subView;
}
- (UIView *)alterBgView {
    if (!_alterBgView) {
        _alterBgView = [[UIView alloc] init];
        _alterBgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _alterBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }
    return _alterBgView;
}
- (LXAlterPromptView *)alterView {
    if (!_alterView) {
        _alterView = [[LXAlterPromptView alloc] init];
        _alterView.frame = CGRectMake(73, 100, 230, 140);
        _alterView.delegate = self;
    }
    return _alterView;
}
- (LXUserInfoDataController *)saveIntoDataController {
    if (!_saveIntoDataController) {
        _saveIntoDataController = [[LXUserInfoDataController alloc] init];
    }
    return _saveIntoDataController;
}
- (LXMineModel *)mineModel {
    if (!_mineModel) {
        _mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    }
    return _mineModel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
