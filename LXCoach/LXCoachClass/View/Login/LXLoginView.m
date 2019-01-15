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
    UILabel *tittleLabel = [[UILabel alloc] init];
    tittleLabel.textColor = TEXT_COLOR_BLACK;
    tittleLabel.font = TEXT_FONT(24);
    tittleLabel.text = @"欢迎登录乐享学驾教练版";
    [self addSubview:tittleLabel];
    
    [self addSubview:self.accountView];
    [self addSubview:self.passwordView];
    [self addSubview:self.loginButton];
    [self addSubview:self.forgetButton];
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.textColor = TEXT_COLOR_GRAY;
    bottomLabel.font = TEXT_FONT(12);
    bottomLabel.text = @"南京驾驶员培训行业协会";
    [self addSubview:bottomLabel];
    
    [tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LXNavigationStatusBar + 48*kAutoSizeScaleX);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self);
    }];
    
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tittleLabel.mas_bottom).offset(53);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(44);
    }];
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_accountView.mas_bottom);
        make.left.right.equalTo(self->_accountView);
        make.height.mas_equalTo(44);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_passwordView.mas_bottom).offset(kAutoSizeScaleX*86);
        make.left.right.equalTo(self->_accountView);
        make.height.mas_equalTo(44);
    }];
    [_forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_loginButton.mas_bottom);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-8);
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
        _accountView = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_bmobile"] placehold:@"请输入您的教练证号"];
        _accountView.textField.text = @"152321198003162427";
    }
    return _accountView;
}

- (LX_ImageText_View *)passwordView{
    if (!_passwordView) {
        _passwordView = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_password"] placehold:@"请输入您的密码"];
        _passwordView.textField.text = @"162427";
    }
    return _passwordView;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitleColor:TEXT_COLOR_GRAY forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_forgetButton addTarget:self action:@selector(forgetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:BG_COLOR_BLUE];
        _loginButton.layer.cornerRadius = 10;
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
