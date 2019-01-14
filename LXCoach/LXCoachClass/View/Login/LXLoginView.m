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
/// icon
@property (nonatomic, strong) UIImageView *iconImageView;
/// 名称
@property (nonatomic, strong) UILabel *lxName;
/// 账号密码登录
//@property (nonatomic, strong) UIButton *acountLoginBtn;
/// 间隔线
//@property (nonatomic, strong) UIView * middleBreakView;
/// 快捷登录
//@property (nonatomic, strong) UIButton *speedyLoginBtn;
/// 登录方式分割线
//@property (nonatomic, strong) UIView *loginWayLine;
/// 选中时的View
//@property (nonatomic, strong) UIView *selectView;

@property (nonatomic, strong) UIImageView *accountIconImage;
/// 账号
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UIView *accountBottomLine;

@property (nonatomic, strong) UIImageView *passwordIconImage;
@property (nonatomic, strong) UIView *passwordBottomLine;
///  密码
@property (nonatomic, strong) UITextField *passwordTextField;
/// 获取验证码
@property (nonatomic, strong) UIButton *obtainTextCode;

/// 忘记密码
@property (nonatomic, strong) UIButton *forgetButton;
/// 登录
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LXLoginView
{
    NSInteger _type;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self subView];
        LX_ImageText_View *acout = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_password"] placehold:@"sss"];
        [self addSubview:acout];
        [acout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.passwordTextField.mas_bottom).offset(130);
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
            make.height.mas_equalTo(68);
        }];
    }
    return self;
}



- (void)subView {
    [self addSubview:self.iconImageView];
    [self addSubview:self.lxName];
//    [self addSubview:self.acountLoginBtn];
//    [self addSubview:self.speedyLoginBtn];
//    [self addSubview:self.middleBreakView];
//    [self addSubview:self.loginWayLine];
//    [self addSubview:self.selectView];
    [self addSubview:self.accountIconImage];
    [self addSubview:self.accountBottomLine];
    [self addSubview:self.accountTextField];
    [self addSubview:self.passwordIconImage];
    [self addSubview:self.passwordBottomLine];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.obtainTextCode];
    [self addSubview:self.forgetButton];
    [self addSubview:self.loginButton];
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
    if (self.accountTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        [self makeToast:@"请输入完整信息"];
        return ;
    }
    if ([self.delegate respondsToSelector:@selector(lx_clickLoginButton:andPasswordOrTestCode:)]) {
        [self.delegate lx_clickLoginButton:self.accountTextField.text andPasswordOrTestCode:self.passwordTextField.text];
    }
}

#pragma mark - getter
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"lx_login_logo"];
    }
    return _iconImageView;
}
- (UILabel *)lxName {
    if (!_lxName) {
        _lxName = [[UILabel alloc] init];
        _lxName.numberOfLines = 0;
        _lxName.textColor = [UIColor colorWithHexString:@"#333333"];
        _lxName.font = [UIFont systemFontOfSize:16];
        NSString *labelText = @"乐享学驾\n教练版";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];//调整行间距
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        _lxName.attributedText = attributedString;
        [_lxName sizeToFit];
    }
    return _lxName;
}
//- (UIButton *)acountLoginBtn {
//    if (!_acountLoginBtn) {
//        _acountLoginBtn = [[UIButton alloc] init];
//        [_acountLoginBtn setTitle:@"账号密码登录" forState:UIControlStateNormal];
//        [_acountLoginBtn setTitleColor:[UIColor colorWithHexString:@"#309CF5"] forState:UIControlStateNormal];
//        _acountLoginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        [_acountLoginBtn addTarget:self action:@selector(acountLoginBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _acountLoginBtn;
//}
//- (UIButton *)speedyLoginBtn {
//    if (!_speedyLoginBtn) {
//        _speedyLoginBtn = [[UIButton alloc] init];
//        [_speedyLoginBtn setTitle:@"手机快捷登陆" forState:UIControlStateNormal];
//        [_speedyLoginBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
//        _speedyLoginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        [_speedyLoginBtn addTarget:self action:@selector(speedyLoginBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _speedyLoginBtn;
//}
//- (UIView *)middleBreakView {
//    if (!_middleBreakView) {
//        _middleBreakView = [[UIView alloc] init];
//        _middleBreakView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
//    }
//    return _middleBreakView;
//}
//- (UIView *)loginWayLine {
//    if (!_loginWayLine) {
//        _loginWayLine = [[UIView alloc] init];
//        _loginWayLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
//    }
//    return _loginWayLine;
//}
//- (UIView *)selectView {
//    if (!_selectView) {
//        _selectView = [[UIView alloc] init];
//        _selectView.backgroundColor = [UIColor colorWithHexString:@"#309CF5"];
//    }
//    return _selectView;
//}

- (UIImageView *)accountIconImage {
    if (!_accountIconImage) {
        _accountIconImage = [[UIImageView alloc] init];
        _accountIconImage.image = [UIImage imageNamed:@"lx_login_bmobile"];
    }
    return _accountIconImage;
}

- (UITextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.font = [UIFont systemFontOfSize:16];
        _accountTextField.textColor = [UIColor colorWithHexString:@"#999999"];
        _accountTextField.placeholder = @"请输入您的身份证或教练证";
        _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _accountTextField.text = @"371501197308219544";
        _accountTextField.text = @"152321198003162427";
    }
    return _accountTextField;
}
- (UIView *)accountBottomLine {
    if (!_accountBottomLine) {
        _accountBottomLine = [[UIView alloc] init];
        _accountBottomLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _accountBottomLine;
}
- (UIImageView *)passwordIconImage {
    if (!_passwordIconImage) {
        _passwordIconImage = [[UIImageView alloc] init];
        _passwordIconImage.image = [UIImage imageNamed:@"lx_login_password"];
    }
    return _passwordIconImage;
}
- (UIView *)passwordBottomLine {
    if (!_passwordBottomLine) {
        _passwordBottomLine = [[UIView alloc] init];
        _passwordBottomLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _passwordBottomLine;
}
- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.font = [UIFont systemFontOfSize:16];
        _passwordTextField.textColor = [UIColor colorWithHexString:@"#999999"];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _passwordTextField.text = @"123456r"; //219544r
        _passwordTextField.text = @"162427";
    }
    return _passwordTextField;
}
- (UIButton *)obtainTextCode {
    if (!_obtainTextCode) {
        _obtainTextCode = [[UIButton alloc] init];
        [_obtainTextCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        _obtainTextCode.titleLabel.font = [UIFont systemFontOfSize:14];
        [_obtainTextCode setTitleColor:[UIColor colorWithHexString:@"#309CF5"] forState:UIControlStateNormal];
//        [_obtainTextCode addTarget:self action:@selector(obtainTextCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        _obtainTextCode.hidden = YES;
    }
    return _obtainTextCode;
}
- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [[UIButton alloc] init];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [_forgetButton addTarget:self action:@selector(forgetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor colorWithHexString:@"#309CF5"]];
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _loginButton.layer.cornerRadius = 10;
        [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
