//
//  LXAlterOrFindStepTwoPasswordView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#define INPUT_HEIGHT 55

#import "LXAlterOrFindStepTwoPasswordView.h"

@interface LXAlterOrFindStepTwoPasswordView()

/// inputOne
@property (nonatomic, strong) UIImageView *oneIconImageView;
@property (nonatomic, strong) UITextField *oneTextFeild;
@property (nonatomic, strong) UIView *oneBottomView;

/// inputTwo
@property (nonatomic, strong) UIImageView *twoIconImageView;
@property (nonatomic, strong) UITextField *twoTextFeild;
@property (nonatomic, strong) UIView *twoBottomView;

/// inputThree
@property (nonatomic, strong) UIImageView *threeIconImageView;
@property (nonatomic, strong) UITextField *threeTextFeild;

/// 确认按钮
@property (nonatomic, strong) UIButton *affirmButton;

@end

@implementation LXAlterOrFindStepTwoPasswordView
{
    NSInteger _type;
}
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
    CGFloat h = INPUT_HEIGHT * 3 + 1.5;
    self.bgView.frame = CGRectMake(x, y, w, h);
    
    x = 23;
    y = 18;
    w = 15;
    h = 19;
    self.oneIconImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.oneIconImageView.frame)+15;
    y = 20;
    w = self.width - (52+20);
    h = 16;
    self.oneTextFeild.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.oneIconImageView.frame) + 18;
    w = self.width - 15;
    h = .5;
    self.oneBottomView.frame = CGRectMake(x, y, w, h);
    
    x = 23;
    y = CGRectGetMaxY(self.oneBottomView.frame) + 18;
    w = 15;
    h = 19;
    self.twoIconImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.twoIconImageView.frame) + 15;
    y = CGRectGetMaxY(self.oneBottomView.frame) + 20;
    w = self.width - (52+20);
    h = 16;
    self.twoTextFeild.frame = CGRectMake(x, y, w, h);;
    
    x = 15;
    y = CGRectGetMaxY(self.twoIconImageView.frame) + 18;
    w = self.width - 15;
    h = .5;
    self.twoBottomView.frame = CGRectMake(x, y, w, h);
    
    x = 23;
    y = CGRectGetMaxY(self.twoBottomView.frame) + 18;
    w = 15;
    h = 19;
    self.threeIconImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.threeIconImageView.frame) + 15;
    y = CGRectGetMaxY(self.twoBottomView.frame) + 20;
    w = self.width - (52+20);
    h = 16;
    self.threeTextFeild.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = self.height-(45+15);
    w = self.width - 30;
    h = 45;
    self.affirmButton.frame = CGRectMake(x, y, w, h);
    
    if (_type == 1) {
        self.bgView.frame = CGRectMake(0, 0, self.width, INPUT_HEIGHT*2 + 1);
    }else if (_type == 2) {
        self.bgView.frame = CGRectMake(0, 0, self.width, INPUT_HEIGHT*3 + 1.5);
    }else {
        self.bgView.frame = CGRectMake(0, 0, self.width, INPUT_HEIGHT*2 + 1);
    }
    
}
- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
}
- (void)subView {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.oneIconImageView];
    [self.bgView addSubview:self.oneTextFeild];
    [self.bgView addSubview:self.oneBottomView];
    [self.bgView addSubview:self.twoIconImageView];
    [self.bgView addSubview:self.twoTextFeild];
    [self.bgView addSubview:self.twoBottomView];
    [self.bgView addSubview:self.threeIconImageView];
    [self.bgView addSubview:self.threeTextFeild];
    [self addSubview:self.affirmButton];
}

#pragma mark - publicMethod
/*
根据type值调整界面

@param type type=1 忘记密码确认密码第二步； type=2 修改密码
*/
- (void)adjustmentViewType:(NSInteger)type {
    _type = type;
    if (type == 1) {
        self.oneTextFeild.placeholder = @"请输入六位数以上字母加数字";
        self.twoTextFeild.placeholder = @"请输入六位数以上字母加数字";
        self.twoBottomView.hidden = YES;
        self.threeIconImageView.hidden = YES;
        self.threeTextFeild.hidden = YES;
        self.bgView.frame = CGRectMake(0, 0, self.width, INPUT_HEIGHT*2 + 1);
        
    }else if (type == 2) {
        self.twoBottomView.hidden = NO;
        self.threeIconImageView.hidden = NO;
        self.threeTextFeild.hidden = NO;
        self.oneTextFeild.placeholder = @"请输入旧密码";
        self.twoTextFeild.placeholder = @"请输入六位数以上字母加数字";
        self.threeTextFeild.placeholder = @"请输入六位数以上字母加数字";
        self.bgView.frame = CGRectMake(0, 0, self.width, INPUT_HEIGHT*3 + 1.5);
    }
}

#pragma mark - Event
- (void)affirmButtonAction {
    if ([self.delegate respondsToSelector:@selector(lx_clickAffirmOldPassword:andNewPassword:andAffirmPassword:)]) {
        [self.delegate lx_clickAffirmOldPassword:self.oneTextFeild.text andNewPassword:self.twoTextFeild.text andAffirmPassword:self.threeTextFeild.text];
    }
}

#pragma mark - getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UIImageView *)oneIconImageView {
    if (!_oneIconImageView) {
        _oneIconImageView = [[UIImageView alloc]init];
        _oneIconImageView.image = [UIImage imageNamed:@"lx_change_testcode"];
    }
    return _oneIconImageView;
}
- (UITextField *)oneTextFeild {
    if (!_oneTextFeild) {
        _oneTextFeild = [[UITextField alloc] init];
        _oneTextFeild.font = [UIFont systemFontOfSize:16];
        _oneTextFeild.textColor = [UIColor colorWithHexString:@"#9A9A9A"];
        _oneTextFeild.placeholder = @"请输入六位数以上字母加数字";
    }
    return _oneTextFeild;
}
- (UIView *)oneBottomView {
    if (!_oneBottomView) {
        _oneBottomView = [[UIView alloc] init];
        _oneBottomView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _oneBottomView;
}
- (UIImageView *)twoIconImageView {
    if (!_twoIconImageView) {
        _twoIconImageView = [[UIImageView alloc] init];
        _twoIconImageView.image = [UIImage imageNamed:@"lx_change_testcode"];
    }
    return _twoIconImageView;
}
- (UITextField *)twoTextFeild {
    if (!_twoTextFeild) {
        _twoTextFeild = [[UITextField alloc] init];
        _oneTextFeild.font = [UIFont systemFontOfSize:16];
        _twoTextFeild.textColor = [UIColor colorWithHexString:@"#9A9A9A"];
        _twoTextFeild.placeholder = @"请输入六位数以上字母加数字";
    }
    return _twoTextFeild;
}
- (UIView *)twoBottomView {
    if (!_twoBottomView) {
        _twoBottomView = [[UIView alloc] init];
        _twoBottomView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _twoBottomView;
}
- (UIImageView *)threeIconImageView {
    if (!_threeIconImageView) {
        _threeIconImageView = [[UIImageView alloc] init];
        _threeIconImageView.image = [UIImage imageNamed:@"lx_change_testcode"];
    }
    return _threeIconImageView;
}
- (UITextField *)threeTextFeild {
    if (!_threeTextFeild) {
        _threeTextFeild = [[UITextField alloc] init];
        _threeTextFeild.font = [UIFont systemFontOfSize:16];
        _threeTextFeild.textColor = [UIColor colorWithHexString:@"#9A9A9A"];
        _threeTextFeild.placeholder = @"请输入六位数以上字母加数字";
    }
    return _threeTextFeild;
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
