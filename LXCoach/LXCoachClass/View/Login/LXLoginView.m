//
//  LXLoginView.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXLoginView.h"
#import "LX_ImageText_View.h"
@interface LXLoginView()
//账号
@property (nonatomic, strong) LX_ImageText_View *accountView;
//密码
@property (nonatomic, strong) LX_ImageText_View *passwordView;
//忘记密码
@property (nonatomic, strong) UIButton *forgetButton;
//登录
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LXLoginView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self subView];
    }
    return self;
}

- (void)subView {
    [self addSubview:self.accountView];
    [self addSubview:self.passwordView];
    [self addSubview:self.loginButton];
    [self addSubview:self.forgetButton];
    
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(48);
        make.top.mas_equalTo(100);
    }];
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_accountView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(48);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_passwordView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(48);
    }];
    [_forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_loginButton.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(48);
    }];
}

#pragma mark - publicMethod

#pragma mark - Event

// 忘记密码
- (void)forgetButtonAction {
    if ([self.delegate respondsToSelector:@selector(lx_clickForgetPasswordButton)]) {
        [self.delegate lx_clickForgetPasswordButton];
    }
}

// 登录
- (void)loginButtonAction {
    NSString *acountText = _accountView.textField.text;
    NSString *passpotText = _passwordView.textField.text;
    if (acountText.length == 0 || passpotText.length == 0) {
        [self makeToast:@"请输入完整信息"];
        return ;
    }
    if ([self.delegate respondsToSelector:@selector(lx_clickLoginButton:andPasswordOrTestCode:)]) {
        [self.delegate lx_clickLoginButton:acountText andPasswordOrTestCode:passpotText];
    }
}

#pragma mark - getter

-(LX_ImageText_View *)accountView{
    if (!_accountView) {
        _accountView = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_password"] placehold:@"sss"];
        _accountView.textField.text = @"";
    }
    return _accountView;
}

- (LX_ImageText_View *)passwordView{
    if (!_passwordView) {
        _passwordView = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_password"] placehold:@"sss"];
        _passwordView.textField.text = @"";
    }
    return _passwordView;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetButton addTarget:self action:@selector(forgetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:[UIColor colorWithHexString:@"#309CF5"]];
        _loginButton.layer.cornerRadius = 10;
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
