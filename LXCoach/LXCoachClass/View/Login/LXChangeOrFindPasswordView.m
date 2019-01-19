//
//  LXChangeOrFindPasswordView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXChangeOrFindPasswordView.h"
#import "NSString+LXTelEmailRegular.h"
#import "LX_Step_View.h"
#import "LX_ImageText_View.h"

@interface LXChangeOrFindPasswordView()

@property (nonatomic, strong) LX_Step_View *step_View;
/// 手机号
@property (nonatomic, strong) LX_ImageText_View *acountView;
/// 验证码
@property (nonatomic, strong) UIImageView *testCodeIconImagge;
@property (nonatomic, strong) UITextField *testCodeTextField;
/// 输入验证码分割线
@property (nonatomic, strong) UIView *testCodeBreakLine;
/// 获取验证码
@property (nonatomic, strong) UIButton *obtainButton;
/// 确认按钮
@property (nonatomic, strong) UIButton *affirmButton;
@end

@implementation LXChangeOrFindPasswordView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self subView];
    }
    return self;
}

- (void)subView {
    _step_View = [LX_Step_View new];
    [self addSubview:_step_View];
    [_step_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.height.mas_equalTo(111*kAutoSizeScaleX);
    }];
    [self addSubview:self.acountView];
    [self.acountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.step_View.mas_bottom);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(46);
    }];
    
    UIView *codeView = [[UIView alloc] init];
    [self addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.acountView);
        make.top.equalTo(self.acountView.mas_bottom);
        make.height.mas_equalTo(46);
    }];
    [codeView addSubview:self.testCodeIconImagge];
    [codeView addSubview:self.testCodeTextField];
    [codeView addSubview:self.testCodeBreakLine];
    [codeView addSubview:self.obtainButton];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = BG_COLOR_GRAY;
    [codeView addSubview:lineView];
    
    UIImage *img =[UIImage imageNamed:@"lx_change_testcode"];
    _testCodeIconImagge.image = img;
    [_testCodeIconImagge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(codeView);
        make.size.mas_equalTo(img.size);
    }];
    [_testCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeView);
        make.left.equalTo(self.testCodeIconImagge.mas_right).offset(16);
        make.right.equalTo(self.testCodeBreakLine.mas_left);
    }];
    [_testCodeBreakLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeView);
        make.right.equalTo(self.obtainButton.mas_left);
        make.size.mas_equalTo(CGSizeMake(0.5, 25));
    }];
    [_obtainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(codeView);
        make.width.mas_equalTo(109);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(codeView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self addSubview:self.affirmButton];
    [_affirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.mas_bottom).offset(85 * kAutoSizeScaleX);
        make.left.right.equalTo(self.acountView);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark - Event
// 获取验证码
- (void)obtainButtonAction:(UIButton *)testCodeBtn {
    if (![NSString lxIsValidateMobilePhoneNumber:self.acountView.textField.text]) {
        [self makeToast:@"请正确输入手机号"];
        return ;
    }
    if ([self.delegate respondsToSelector:@selector(lx_obtainTestCodeButton:andPhoneNumber:)]) {
        [self.delegate lx_obtainTestCodeButton:testCodeBtn andPhoneNumber:self.acountView.textField.text];
    }
}
// 确认
- (void)affirmButtonAction {
    if (![NSString lxIsValidateMobilePhoneNumber:self.acountView.textField.text]) {
        [self makeToast:@"请正确输入手机号"];
        return ;
    }
    if (self.testCodeTextField.text.length == 0) {
        [self makeToast:@"请输入验证码"];
        return ;
    }
    if ([self.delegate respondsToSelector:@selector(lx_clickAffirmButton:andPhoneNumber:)]) {
        [self.delegate lx_clickAffirmButton:self.testCodeTextField.text andPhoneNumber:self.acountView.textField.text];
    }
}

#pragma mark - setter
- (void)setType:(NSInteger)type {
    _type = type;
    if (self.type == 2) {
        self.acountView.textField.placeholder = @"请输入您当前手机号";
        _step_View.explainLabel.text = @"验证当前手机";
    }else if (self.type == 3) {
        self.acountView.textField.placeholder = @"请输入您的新手机号";
        _step_View.explainLabel.text = @"确认更换手机";
    }else{
        self.acountView.textField.placeholder = @"请输入您的手机号";
        _step_View.explainLabel.text = @"输入手机号";
    }
    if (self.type == 3) {
        _step_View.stepOneImgView.image = [UIImage imageNamed:@"lx_step_one"];
        _step_View.stepTwoImgView.image = [UIImage imageNamed:@"lx_step_two_true"];
        [_affirmButton setTitle:@"确认" forState:UIControlStateNormal];
    }else{
        _step_View.stepOneImgView.image = [UIImage imageNamed:@"lx_step_one"];
        _step_View.stepTwoImgView.image = [UIImage imageNamed:@"lx_step_two_false"];
        [_affirmButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
}

#pragma mark - getter
- (LX_ImageText_View *)acountView{
    if (!_acountView) {
        _acountView = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_bmobile"] placehold:@""];
        _acountView.textField.keyboardType = UIKeyboardTypePhonePad;
        _acountView.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _acountView;
}

- (UIImageView *)testCodeIconImagge {
    if (!_testCodeIconImagge) {
        _testCodeIconImagge = [[UIImageView alloc] init];
    }
    return _testCodeIconImagge;
}

- (UITextField *)testCodeTextField {
    if (!_testCodeTextField) {
        _testCodeTextField = [[UITextField alloc] init];
        _testCodeTextField.font = [UIFont systemFontOfSize:15];
        _testCodeTextField.textColor = [UIColor colorWithHexString:@"#9A9A9A"];
        _testCodeTextField.placeholder = @"请输入短信验证码";
        _testCodeTextField.keyboardType = UIKeyboardTypePhonePad;
        _testCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _testCodeTextField.secureTextEntry = YES;
    }
    return _testCodeTextField;
}

- (UIButton *)obtainButton {
    if (!_obtainButton) {
        _obtainButton = [[UIButton alloc] init];
        _obtainButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_obtainButton setTitleColor:TEXT_COLOR_BLUE forState:UIControlStateNormal];
        [_obtainButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_obtainButton addTarget:self action:@selector(obtainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _obtainButton;
}
- (UIView *)testCodeBreakLine {
    if (!_testCodeBreakLine) {
        _testCodeBreakLine = [[UIView alloc] init];
        _testCodeBreakLine.backgroundColor = BG_COLOR_GRAY;
    }
    return _testCodeBreakLine;
}

- (UIButton *)affirmButton {
    if (!_affirmButton) {
        _affirmButton = [[UIButton alloc] init];
        [_affirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_affirmButton setBackgroundColor:BG_COLOR_BLUE];
        _affirmButton.layer.cornerRadius = 5;
        _affirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_affirmButton addTarget:self action:@selector(affirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _affirmButton;
}

@end
