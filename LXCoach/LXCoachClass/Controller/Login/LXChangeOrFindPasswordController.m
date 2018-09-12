//
//  LXChangeOrFindPasswordController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXChangeOrFindPasswordController.h"
#import "LXAlterOrFindStepTwoPasswordController.h"
#import "LXCodeDataController.h"
#import "LXCodeUrlSessionTask.h"
#import "LXFindPassWordDataController.h"
#import "LXFindPassWordUrlSessionTask.h"
#import "LXChangeOrFindPasswordView.h"
#import "LXCommonNavView.h"
#import "UIButton+LXCountDown.h"

@interface LXChangeOrFindPasswordController ()<LXChangeOrFindPasswordViewDelegate,LXCommonNavViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXChangeOrFindPasswordView *subView;
@property (nonatomic, strong) LXCodeDataController *codeDataController;
@property (nonatomic, strong) LXFindPassWordDataController *findPasswordStep1;
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
//        [self.findPasswordStep1 lxReuqestFindPassWordWithPhone:phoneNumber msgCode:testCode completionBlock:^(LXFindPassWordResponseObject *responseModel) {
//            if (responseModel.flg == 1) {
                LXAlterOrFindStepTwoPasswordController *alterPasswordVC = [[LXAlterOrFindStepTwoPasswordController alloc] init];
                alterPasswordVC.type = 1 ;
                alterPasswordVC.navTitleString = @"找回密码";
                alterPasswordVC.phoneNumber = phoneNumber;
                [self.navigationController pushViewController:alterPasswordVC animated:YES];
//            }else {
//                [self.view makeToast:responseModel.msg];
//            }
//        }];
    }else if (self.type == 2){
        LXChangeOrFindPasswordController *findPasswordVC = [[LXChangeOrFindPasswordController alloc] init];
        findPasswordVC.type = 3;
        [self.navigationController pushViewController:findPasswordVC animated:YES];
    }else if (self.type == 3) {
        // 确认修改密码
    }
}

#pragma mark - getter
- (void)setType:(NSInteger)type {
    _type = type;
    if (self.type == 1) {
        [self.navView updateNavigationTitle:@"找回密码"];
        self.subView.acountTextField.placeholder = @"请输入您的当前手机号";
    }else {
        [self.navView updateNavigationTitle:@"更换登录手机号"];
        if (self.type == 2) {
            self.subView.acountTextField.placeholder = @"请输入您的当前手机号";
        }else if (self.type == 3) {
            self.subView.acountTextField.placeholder = @"请输入您的新手机号";
        }
    }
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
