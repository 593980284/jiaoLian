//
//  LXChangeOrFindPasswordController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXChangeOrFindPasswordController.h"
#import "LXAlterOrFindStepTwoPasswordController.h"
#import "LXMineMessageAlterController.h"
#import "LXCodeDataController.h"
#import "LXCodeUrlSessionTask.h"
#import "LXFindPassWordDataController.h"
#import "LXFindPassWordUrlSessionTask.h"
#import "LXChangePhoneNumDataController.h"
#import "LXChangePhoneNumUrlSessionTask.h"
#import "LXSaveNewPhoneNumDataController.h"
#import "LXSaveNewPhoneNumUrlSessionTask.h"
#import "LXChangeOrFindPasswordView.h"
#import "LXCommonNavView.h"
#import "UIButton+LXCountDown.h"
#import "LXMineModel.h"

@interface LXChangeOrFindPasswordController ()<LXChangeOrFindPasswordViewDelegate,LXCommonNavViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXChangeOrFindPasswordView *subView;
/// 获取验证码
@property (nonatomic, strong) LXCodeDataController *codeDataController;
@property (nonatomic, strong) LXFindPassWordDataController *findPasswordStep1;
/// 换手机号第一步
@property (nonatomic, strong) LXChangePhoneNumDataController *changePhoneNumDataController;
/// 换手机号第二步
@property (nonatomic, strong) LXSaveNewPhoneNumDataController *saveNewPhoneNumDataController;
@end

@implementation LXChangeOrFindPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
}

#pragma mark - LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - LXChangeOrFindPasswordViewDelegate
/**
 获取验证码
 
 @param testCodeButton  按钮
 @param phoneNumber     电话号码
 */
- (void)lx_obtainTestCodeButton:(UIButton *)testCodeButton andPhoneNumber:(NSString *)phoneNumber {
    [self.codeDataController lxReuqestCodeWithPhone:phoneNumber completionBlock:^(LXCodeResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            [testCodeButton countDownWithTime:60 withTitle:@"重新获取" andCountDownTitle:@"" countDoneBlock:^(UIButton *testCode) {
                
            } isInteraction:NO];
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

/**
 点击确认
 
 @param  testCode 验证码
 @param  phoneNumber 手机号
 */
- (void)lx_clickAffirmButton:(NSString *)testCode andPhoneNumber:(NSString *)phoneNumber {
    if (self.type == 1) {
        [self.findPasswordStep1 lxReuqestFindPassWordWithPhone:phoneNumber msgCode:testCode completionBlock:^(LXFindPassWordResponseObject *responseModel) {
            if (responseModel.flg == 1) {
                LXAlterOrFindStepTwoPasswordController *alterPasswordVC = [[LXAlterOrFindStepTwoPasswordController alloc] init];
                alterPasswordVC.type = 1 ;
                alterPasswordVC.navTitleString = @"找回密码";
                alterPasswordVC.phoneNumber = phoneNumber;
                [self.navigationController pushViewController:alterPasswordVC animated:YES];
            }else {
                [self.view makeToast:responseModel.msg];
            }
        }];
    }else if (self.type == 2){
        // 更换手机号第一步
        LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
        [self.changePhoneNumDataController lxReuqestChangePhoneNumWithCertNo:mineModel.certNo phone:phoneNumber msgCode:testCode completionBlock:^(LXChangePhoneNumResponseObject *responseModel) {
            if (responseModel.flg == 1) {
                LXChangeOrFindPasswordController *findPasswordVC = [[LXChangeOrFindPasswordController alloc] init];
                findPasswordVC.type = 3;
                [self.navigationController pushViewController:findPasswordVC animated:YES];
            }else {
                [self.view makeToast:responseModel.msg];
            }
        }];
    }else if (self.type == 3) {
        // 更换手机号第二步
        LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
        [self.saveNewPhoneNumDataController lxReuqestSaveNewPhoneNumWithCertNo:mineModel.certNo phone:phoneNumber msgCode:testCode completionBlock:^(LXSaveNewPhoneNumResponseObject *responseModel) {
            if (responseModel.flg == 1) {
                // 返回到个人设置页面
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[LXMineMessageAlterController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
            }else {
                [self.view makeToast:responseModel.msg];
            }
        }];
    }
}

#pragma mark - setter
- (void)setType:(NSInteger)type {
    _type = type;
    if (self.type == 1) {
        [self.navView updateNavigationTitle:@"找回密码"];
    }else {
        [self.navView updateNavigationTitle:@"更换登录手机号"];
    }
    self.subView.type = type;
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] init];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (LXChangeOrFindPasswordView *)subView {
    if (!_subView) {
        _subView = [[LXChangeOrFindPasswordView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.navView.frame));
        _subView.delegate = self;
    }
    return _subView;
}
- (LXCodeDataController *)codeDataController {
    if (!_codeDataController) {
        _codeDataController = [[LXCodeDataController alloc] init];
    }
    return _codeDataController;
}
- (LXFindPassWordDataController *)findPasswordStep1 {
    if (!_findPasswordStep1) {
        _findPasswordStep1 = [[LXFindPassWordDataController alloc] init];
    }
    return _findPasswordStep1;
}
- (LXChangePhoneNumDataController *)changePhoneNumDataController {
    if (!_changePhoneNumDataController) {
        _changePhoneNumDataController = [[LXChangePhoneNumDataController alloc] init];
    }
    return _changePhoneNumDataController;
}
- (LXSaveNewPhoneNumDataController *)saveNewPhoneNumDataController {
    if (!_saveNewPhoneNumDataController) {
        _saveNewPhoneNumDataController = [[LXSaveNewPhoneNumDataController alloc] init];
    }
    return _saveNewPhoneNumDataController;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
