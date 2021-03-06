//
//  LXLoginController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXLoginController.h"
#import "LXChangeOrFindPasswordController.h"
#import "LXTabBarController.h"
#import "LXNavigationController.h"
#import "LXLoginView.h"
#import "LXLoginDataController.h"
#import "LXLoginUrlSessionTask.h"
#import "UIButton+LXCountDown.h"
#import "LXMineModel.h"
#import <QQ_XGPush/XGPush.h>
#import "LXNavigationManager.h"

@interface LXLoginController ()<LXLoginViewDelegete>
@property (nonatomic, strong) LXLoginView *subView;
@property (nonatomic, strong) LXLoginDataController *loginDataController;
@end

@implementation LXLoginController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.subView];
}

#pragma mark - private
- (void)popContoller {
    LXTabBarController *tabBarController = [[LXTabBarController alloc]init];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = tabBarController;
    
}
#pragma mark - LXLoginViewDelegete

/**
 点击登录按钮
 
 @param acount 账号
 @param code 密码或者验证码
 */
- (void)lx_clickLoginButton:(NSString *)acount andPasswordOrTestCode:(NSString *)code {
    [self.loginDataController lxReuqestLoginWithCertNo:acount password:code completionBlock:^(LXLoginResponseObject *responseModel) {
        if (responseModel.flg==1) {
            [self.view makeToast:responseModel.msg];
            // 绑定推送帐号
            [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:responseModel.data.certNo type:XGPushTokenBindTypeAccount];
            // 存储用户数据
            [LXCacheManager storeObject:responseModel.data forKey:@"LXMineModel"];
            [self  performSelector:@selector(popContoller) withObject:nil afterDelay:1.0f];
        }else {
            [self.view makeToast:responseModel.msg];
        }
    }];
}

/**
 点击忘记密码按钮
 */
- (void)lx_clickForgetPasswordButton {
    LXChangeOrFindPasswordController *findPasswordVC = [[LXChangeOrFindPasswordController alloc] init];
    findPasswordVC.type = 1;
    [[LXNavigationManager lx_currentNavigationController] pushViewController:findPasswordVC animated:YES];
}

#pragma mark - getter
- (LXLoginView *)subView {
    if (!_subView) {
        _subView = [[LXLoginView alloc] init];
        _subView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _subView.delegate = self;
    }
    return _subView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (LXLoginDataController *)loginDataController {
    if (!_loginDataController) {
        _loginDataController = [LXLoginDataController new];
    }
    return _loginDataController;
}

@end
