//
//  LXChangeOrFindPasswordController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXChangeOrFindPasswordController.h"
#import "LXAlterOrFindStepTwoPasswordController.h"
#import "LXChangeOrFindPasswordView.h"
#import "LXCommonNavView.h"

@interface LXChangeOrFindPasswordController ()<LXChangeOrFindPasswordViewDelegate,LXCommonNavViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXChangeOrFindPasswordView *subView;
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
 点击确认
 
 @param testCode 验证码
 */
- (void)lx_clickAffirmButton:(NSString *)testCode {
    if (self.type == 1) {
        LXAlterOrFindStepTwoPasswordController *alterPasswordVC = [[LXAlterOrFindStepTwoPasswordController alloc] init];
        alterPasswordVC.type = 1 ;
        alterPasswordVC.navTitleString = @"找回密码";
        [self.navigationController pushViewController:alterPasswordVC animated:YES];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
