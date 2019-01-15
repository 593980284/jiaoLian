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

@interface LXChangeOrFindPasswordView()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) LX_Step_View *step_View;
/// 手机号
@property (nonatomic, strong) UIImageView *acountIconImage;

@property (nonatomic, strong) UIView *acountBottomLineView;
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
        self.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        [self subView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width;
    CGFloat h = 111;
    self.bgView.frame = CGRectMake(x, y, w, h);
    
    x = 23;
    y = 19;
    w = 14;
    h = 18;
    self.acountIconImage.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.acountIconImage.frame) + 14;
    y = 20;
    w = self.width - (50 + 20);
    h = 16;
    self.acountTextField.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.acountIconImage.frame) + 19;
    w = self.width - 15;
    h = .5;
    self.acountBottomLineView.frame = CGRectMake(x, y, w, h);
    
    x = 23;
    y = CGRectGetMaxY(self.acountBottomLineView.frame) + 18;
    w = 15;
    h = 19;
    self.testCodeIconImagge.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.testCodeIconImagge.frame) + 13;
    y = CGRectGetMaxY(self.acountBottomLineView.frame) + 20;
    w = self.width - (105+60);
    h = 16;
    self.testCodeTextField.frame = CGRectMake(x, y, w, h);
    
    x = self.width - (78+15);
    y = CGRectGetMaxY(self.acountBottomLineView.frame)+21;
    w = 78;
    h = 14;
    self.obtainButton.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.obtainButton.frame) - 15.5;
    y = CGRectGetMaxY(self.acountBottomLineView.frame) + 18;
    w = .5;
    h = 21;
    self.testCodeBreakLine.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    if (@available(iOS 11, *)) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        y = self.height - (15 + 45) - keyWindow.safeAreaInsets.bottom;
    } else {
        y = self.height - (15 + 45);
    }
    w = self.width - 30;
    h = 45;
    self.affirmButton.frame = CGRectMake(x, y, w, h);
    
}
- (void)subView {
    [self addSubview:self.bgView];
    _step_View = [LX_Step_View new];
    [self addSubview:_step_View];
    [_step_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
    }];
    [self.bgView addSubview:self.acountIconImage];
    [self.bgView addSubview:self.acountTextField];
    [self.bgView addSubview:self.acountBottomLineView];
    [self.bgView addSubview:self.testCodeIconImagge];
    [self.bgView addSubview:self.testCodeTextField];
    [self.bgView addSubview:self.obtainButton];
    [self.bgView addSubview:self.testCodeBreakLine];
    [self addSubview:self.affirmButton];
}

#pragma mark - Event
// 获取验证码
- (void)obtainButtonAction:(UIButton *)testCodeBtn {
    if (![NSString lxIsValidateMobilePhoneNumber:self.acountTextField.text]) {
        [self makeToast:@"请正确输入手机号"];
        return ;
    }
    if ([self.delegate respondsToSelector:@selector(lx_obtainTestCodeButton:andPhoneNumber:)]) {
        [self.delegate lx_obtainTestCodeButton:testCodeBtn andPhoneNumber:self.acountTextField.text];
    }
}
// 确认
- (void)affirmButtonAction {
    if (![NSString lxIsValidateMobilePhoneNumber:self.acountTextField.text]) {
        [self makeToast:@"请正确输入手机号"];
        return ;
    }
    if (self.testCodeTextField.text.length == 0) {
        [self makeToast:@"请输入验证码"];
        return ;
    }
    if ([self.delegate respondsToSelector:@selector(lx_clickAffirmButton:andPhoneNumber:)]) {
        [self.delegate lx_clickAffirmButton:self.testCodeTextField.text andPhoneNumber:self.acountTextField.text];
    }
}

#pragma mark - setter
- (void)setType:(NSInteger)type {
    _type = type;
    if (self.type == 1) {
        self.acountTextField.placeholder = @"请输入您的手机号";
    }else {
        if (self.type == 2) {
            self.acountTextField.placeholder = @"请输入您当前手机号";
        }else if (self.type == 3) {
            self.acountTextField.placeholder = @"请输入您的新手机号";
        }
    }
    _step_View.selectedIndex = 1;
}

#pragma mark - getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  = [UIColor whiteColor];
    }
    return _bgView;
}
- (UIImageView *)acountIconImage {
    if (!_acountIconImage) {
        _acountIconImage = [[UIImageView alloc] init];
        _acountIconImage.image = [UIImage imageNamed:@"lx_login_bmobile"];
    }
    return _acountIconImage;
}
- (UITextField *)acountTextField {
    if (!_acountTextField) {
        _acountTextField = [[UITextField alloc] init];
        _acountTextField.font = [UIFont systemFontOfSize:16];
        _acountTextField.textColor = [UIColor colorWithHexString:@"#9A9A9A"];
        _acountTextField.keyboardType = UIKeyboardTypePhonePad;
        _acountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _acountTextField;
}
- (UIView *)acountBottomLineView {
    if (!_acountBottomLineView) {
        _acountBottomLineView = [[UIView alloc] init];
        _acountBottomLineView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _acountBottomLineView;
}

- (UIImageView *)testCodeIconImagge {
    if (!_testCodeIconImagge) {
        _testCodeIconImagge = [[UIImageView alloc] init];
        _testCodeIconImagge.image = [UIImage imageNamed:@"lx_change_testcode"];
    }
    return _testCodeIconImagge;
}

- (UITextField *)testCodeTextField {
    if (!_testCodeTextField) {
        _testCodeTextField = [[UITextField alloc] init];
        _testCodeTextField.font = [UIFont systemFontOfSize:16];
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
        [_obtainButton setTitleColor:[UIColor colorWithHexString:@"#309CF5"] forState:UIControlStateNormal];
        [_obtainButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_obtainButton addTarget:self action:@selector(obtainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _obtainButton;
}
- (UIView *)testCodeBreakLine {
    if (!_testCodeBreakLine) {
        _testCodeBreakLine = [[UIView alloc] init];
        _testCodeBreakLine.backgroundColor = [UIColor colorWithHexString:@"#CFCFCF"];
    }
    return _testCodeBreakLine;
}

- (UIButton *)affirmButton {
    if (!_affirmButton) {
        _affirmButton = [[UIButton alloc] init];
        [_affirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_affirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_affirmButton setBackgroundColor:[UIColor colorWithHexString:@"#309CF5"]];
        _affirmButton.layer.cornerRadius = 5;
        _affirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_affirmButton addTarget:self action:@selector(affirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _affirmButton;
}

@end
