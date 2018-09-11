//
//  LXAlterOrFindStepTwoPasswordController.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXAlterOrFindStepTwoPasswordController.h"
#import "LXAlterOrFindStepTwoPasswordView.h"
#import "LXCommonNavView.h"

@interface LXAlterOrFindStepTwoPasswordController ()<LXAlterOrFindStepTwoPasswordViewDelegate,LXCommonNavViewDelegate>
@property (nonatomic, strong) LXCommonNavView *navView;
@property (nonatomic, strong) LXAlterOrFindStepTwoPasswordView *subView;
@end

@implementation LXAlterOrFindStepTwoPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.subView];
    [self.subView adjustmentViewType:self.type];
}
#pragma mark -LXCommonNavViewDelegate
- (void)lx_clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - LXAlterOrFindStepTwoPasswordViewDelegate
/**
 修改/找回密码（第二步）
 
 @param oldPassword 以前的密码
 @param newPassword 新密码
 @param affirmPassword 确认新密码
 */
- (void)lx_clickAffirmOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword andAffirmPassword:(NSString *)affirmPassword {
    
}

#pragma mark - getter
- (LXCommonNavView *)navView {
    if (!_navView) {
        _navView = [[LXCommonNavView alloc] initWithTitle:self.navTitleString];
        _navView.delegate = self;
        _navView.leftButtonImage = [UIImage imageNamed:@"lx_nav_back"];
    }
    return _navView;
}
- (LXAlterOrFindStepTwoPasswordView *)subView {
    if (!_subView) {
        _subView = [[LXAlterOrFindStepTwoPasswordView alloc] init];
        _subView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), kScreenWidth, kScreenHeight - CGRectGetHeight(self.navView.frame));
    }
    return _subView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
