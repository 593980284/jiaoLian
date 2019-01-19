//
//  LXAlterOrFindStepTwoPasswordView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#define INPUT_HEIGHT 55

#import "LXAlterOrFindStepTwoPasswordView.h"
#import "LX_ImageText_View.h"
#import "LX_Step_View.h"
@interface LXAlterOrFindStepTwoPasswordView()
//step
@property (nonatomic, strong) LX_Step_View *stepView;
/// inputOne
@property (nonatomic, strong) LX_ImageText_View *oldView;
/// inputTwo
@property (nonatomic, strong) LX_ImageText_View *newView;
/// inputThree
@property (nonatomic, strong) LX_ImageText_View *newTwoView;
//
@property (nonatomic,strong) UILabel *explaiLabel;
/// 确认按钮
@property (nonatomic, strong) UIButton *affirmButton;
@end

@implementation LXAlterOrFindStepTwoPasswordView
{
    NSInteger _type;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self subView];
    }
    return self;
}
- (void)subView {
    [self addSubview:self.stepView];
    [self addSubview:self.oldView];
    [self addSubview:self.newView];
    [self addSubview:self.newTwoView];
    [_stepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.height.mas_equalTo(111*kAutoSizeScaleX);
    }];
    [_oldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stepView.mas_bottom);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(46);
    }];
    [_newView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oldView.mas_bottom);
        make.left.right.equalTo(self.oldView);
        make.height.mas_equalTo(46);
    }];
    [_newTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.newView.mas_bottom);
        make.left.right.height.equalTo(self.newView);
    }];
    [self addSubview:self.affirmButton];
    [_affirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.newTwoView.mas_bottom).offset(85 * kAutoSizeScaleX);
        make.left.right.equalTo(self.newTwoView);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *explaiLabel = [UILabel new];
    explaiLabel.text = @"请将密码设置为6位数以上字母或者数字组合";
    explaiLabel.textColor = TEXT_COLOR_GRAY;
    explaiLabel.font = TEXT_FONT(12);
    _explaiLabel = explaiLabel;
    [self addSubview:explaiLabel];
    [explaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.newTwoView);
        make.top.equalTo(self.newTwoView.mas_bottom);
        make.height.mas_equalTo(28);
    }];
}

#pragma mark - publicMethod
/*
 根据type值调整界面
 
 @param type type=1 忘记密码确认密码第二步； type=2 修改密码
 */
- (void)adjustmentViewType:(NSInteger)type {
    _type = type;
    if (type == 1) {
        [_oldView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        _oldView.hidden = YES;
        _newView.textField.placeholder = @"请输入您的密码";
    }else if (type == 2) {
        [_stepView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
        }];
        _stepView.hidden = YES;
        _explaiLabel.hidden = YES;
    }
}

#pragma mark - Event
- (void)affirmButtonAction {
    if ([self.delegate respondsToSelector:@selector(lx_clickAffirmOldPassword:andNewPassword:andAffirmPassword:)]) {
        if (_newView.textField.text.length < 6 || _newTwoView.textField.text.length < 6) {
            [self makeToast:@"输入密码长度不够"];
            return ;
        }
        if (![_newView.textField.text isEqualToString:_newTwoView.textField.text]) {
            [self makeToast:@"两次输入的密码不一致"];
            return ;
        }
        [self.delegate lx_clickAffirmOldPassword:_oldView.textField.text andNewPassword:_newView.textField.text andAffirmPassword:_newTwoView.textField.text];
    }
}

#pragma mark - getter

- (LX_Step_View *)stepView{
    if (!_stepView) {
        _stepView = [LX_Step_View new];
        _stepView.stepOneImgView.image = [UIImage imageNamed:@"lx_step_one"];
        _stepView.stepTwoImgView.image = [UIImage imageNamed:@"lx_step_two_true"];
        _stepView.explainLabel.text = @"确认登录密码";
    }
    return _stepView;
}
-(LX_ImageText_View *)oldView{
    if (!_oldView) {
        _oldView = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_password"] placehold:@"请输入您的旧密码"];
        _oldView.textField.secureTextEntry = YES;
    }
    return _oldView;
}
-(LX_ImageText_View *)newView{
    if (!_newView) {
        _newView = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_password"] placehold:@"请输入6位数以上字母或数字组合"];
        _newView.textField.secureTextEntry = YES;
    }
    return _newView;
}
-(LX_ImageText_View *)newTwoView{
    if (!_newTwoView) {
        _newTwoView = [[LX_ImageText_View alloc] initWithImage:[UIImage imageNamed:@"lx_login_password"] placehold:@"请重复输入新密码"];
        _newTwoView.textField.secureTextEntry = YES;
    }
    return _newTwoView;
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
