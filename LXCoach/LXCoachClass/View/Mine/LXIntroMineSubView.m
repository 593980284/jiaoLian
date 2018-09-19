//
//  LXIntroMineSubView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXIntroMineSubView.h"
#import "LXMineModel.h"

@interface LXIntroMineSubView ()
@property (nonatomic, strong) UIImageView *headerImageView;
/// 证件号
@property (nonatomic, strong) UILabel *credentialsNumber;
/// 姓名+车牌号
@property (nonatomic, strong) UILabel *nameLicenseNumber;
/// 分割线
@property (nonatomic, strong) UIView *breakLineView;
/// 教龄
@property (nonatomic, strong) UILabel *schoolAge;
/// 个人简介
@property (nonatomic, strong) UILabel *introLabel;

/// 确认按钮
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) LXMineModel *mineModel;
@end

@implementation LXIntroMineSubView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headerImageView];
        [self addSubview:self.credentialsNumber];
        [self addSubview:self.nameLicenseNumber];
        [self addSubview:self.breakLineView];
        [self addSubview:self.schoolAge];
        [self addSubview:self.introLabel];
        [self addSubview:self.introDetaile];
        [self addSubview:self.confirmButton];
        
        [self valueToView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = 22;
    CGFloat w = 60*kAutoSizeScaleX;
    CGFloat h = 60*kAutoSizeScaleX;
    self.headerImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.headerImageView.frame) + 18;
    y = 39;
    w = self.width - (60*kAutoSizeScaleX+18+15+15);
    h = 12;
    self.credentialsNumber.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.headerImageView.frame) + 18;
    y = CGRectGetMaxY(self.credentialsNumber.frame)+10;
    w = self.width - (60*kAutoSizeScaleX+18+15+15);
    h = 12;
    self.nameLicenseNumber.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = CGRectGetMaxY(self.headerImageView.frame)+20;
    w = self.width;
    h = .5;
    self.breakLineView.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.breakLineView.frame) + 10;
    w = self.width - 30;
    h = 14;
    self.schoolAge.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.schoolAge.frame) + 18;
    w = self.width - 30;
    h = 16;
    self.introLabel.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.introLabel.frame) + 10;
    w = self.width - 30;
    h = self.height - (CGRectGetMaxY(self.introLabel.frame)+10+13+45+40);
    self.introDetaile.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.introDetaile.frame) + 39;
    w = self.width - 30;
    h = 45;
    self.confirmButton.frame = CGRectMake(x, y, w, h);
    
}
- (void)valueToView {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.mineModel.photo] placeholderImage:[UIImage imageNamed:@"lx_header_placeholder"]];
    self.credentialsNumber.text = self.mineModel.phone;
    self.nameLicenseNumber.text = [NSString stringWithFormat:@"%@  %@",self.mineModel.coachName,self.mineModel.carNo];
    self.schoolAge.text = [NSString stringWithFormat:@"教龄  %@年",self.mineModel.teachAge];
    self.introDetaile.text = [NSString stringWithFormat:@"%@",self.mineModel.present];
}
#pragma mark - Event
- (void)confirmButtonAction {
    if ([self.delegate respondsToSelector:@selector(lx_alterMineMessage:)]) {
        [self.delegate lx_alterMineMessage:self.introDetaile.text];
    }
}
#pragma mark - getter
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _headerImageView.layer.cornerRadius = 60*kAutoSizeScaleX/2;
        _headerImageView.clipsToBounds = YES;
        _headerImageView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _headerImageView.layer.borderWidth = .5;
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerImageView;
}
- (UILabel *)credentialsNumber {
    if (!_credentialsNumber) {
        _credentialsNumber = [[UILabel alloc] init];
        _credentialsNumber.font = [UIFont systemFontOfSize:15];
        _credentialsNumber.textColor = [UIColor colorWithHexString:@"#0A0A0A"];
        _credentialsNumber.textAlignment = NSTextAlignmentLeft;
    }
    return _credentialsNumber;
}
- (UILabel *)nameLicenseNumber {
    if (!_nameLicenseNumber) {
        _nameLicenseNumber = [[UILabel alloc] init];
        _nameLicenseNumber.font = [UIFont systemFontOfSize:14];
        _nameLicenseNumber.textAlignment = NSTextAlignmentLeft;
        _nameLicenseNumber.textColor = [UIColor colorWithHexString:@"#0A0A0A"];
    }
    return _nameLicenseNumber;
}
- (UIView *)breakLineView {
    if (!_breakLineView) {
        _breakLineView = [[UIView alloc] init];
        _breakLineView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _breakLineView;
}
- (UILabel *)schoolAge {
    if (!_schoolAge) {
        _schoolAge = [[UILabel alloc] init];
        _schoolAge.font = [UIFont systemFontOfSize:15];
        _schoolAge.textColor = [UIColor colorWithHexString:@"#333333"];
        _schoolAge.textAlignment = NSTextAlignmentLeft;
    }
    return _schoolAge;
}
- (UILabel *)introLabel {
    if (!_introLabel) {
        _introLabel = [[UILabel alloc] init];
        _introLabel.textAlignment = NSTextAlignmentLeft;
        _introLabel.font = [UIFont systemFontOfSize:16];
        _introLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _introLabel.text = @"个人简介";
    }
    return _introLabel;
}
- (UITextView *)introDetaile {
    if (!_introDetaile) {
        _introDetaile = [[UITextView alloc] init];
        _introDetaile.font = [UIFont systemFontOfSize:14];
        _introDetaile.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _introDetaile.layer.borderWidth = .5;
    }
    return _introDetaile;
}
- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_confirmButton setTintColor:[UIColor whiteColor]];
        [_confirmButton setBackgroundColor:[UIColor colorWithHexString:@"#309CF5"]];
        _confirmButton.layer.cornerRadius = 5;
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
- (LXMineModel *)mineModel {
    if (!_mineModel) {
        _mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    }
    return _mineModel;
}
@end
