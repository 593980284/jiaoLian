//
//  LXStudentDetaileHeaderView.m
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentDetaileHeaderView.h"

@interface LXStudentDetaileHeaderView()
@property (nonatomic, strong) UIImageView *iconImageView;
/// 姓名
@property (nonatomic, strong) UILabel *nameLabel;
/// 手机号
@property (nonatomic, strong) UILabel *phoneNumber;
/// 星星的父视图
@property (nonatomic, strong) UIView * startFatherView;
/// 评分
@property (nonatomic, strong) UILabel *scoreNumber;
/// 分割线
@property (nonatomic, strong) UIView *bottomBreakLine;

@property (nonatomic, strong) NSMutableArray *startArr;
@end

@implementation LXStudentDetaileHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneNumber];
        [self addSubview:self.startFatherView];
        [self addSubview:self.scoreNumber];
        [self addSubview:self.bottomBreakLine];
        [self valueToSubView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = 15;
    CGFloat w = 100 * kAutoSizeScaleX;
    CGFloat h = 80 *kAutoSizeScaleX;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 10;
    y = CGRectGetMinY(self.iconImageView.frame) + 5;
    w = self.width - (100 * kAutoSizeScaleX +15+10+15);
    h = 16;
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 12;
    y = CGRectGetMaxY(self.nameLabel.frame) + 11;
    w = self.width - (100 * kAutoSizeScaleX +15+12+15);
    h = 11;
    self.phoneNumber.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 11;
    y = CGRectGetMaxY(self.phoneNumber.frame) + 11;
    w = 15*kAutoSizeScaleX * 5 + 4 * 5;
    h = 15*kAutoSizeScaleX;
    self.startFatherView.frame = CGRectMake(x, y, w, h);
    
    [self.startArr enumerateObjectsUsingBlock:^(UIImageView  *imageViewObj, NSUInteger idx, BOOL * _Nonnull stop) {
        imageViewObj.frame = CGRectMake((15*kAutoSizeScaleX+5) * idx , 0, 15*kAutoSizeScaleX, 15*kAutoSizeScaleX);
    }];
    
    x = CGRectGetMaxX(self.startFatherView.frame)+10;
    y =  CGRectGetMaxY(self.phoneNumber.frame) + 11;
    w = 45;
    h = 13;
    self.scoreNumber.frame = CGRectMake(x, y, w, h);
    self.scoreNumber.centerY = self.startFatherView.centerY;
    
    x = 0;
    y = self.height - .5;
    w = self.width;
    h = .5;
    self.bottomBreakLine.frame = CGRectMake(x, y, w, h);
}

- (void)valueToSubView {
    self.nameLabel.text = @"张三";
    self.phoneNumber.text = @"13436595848";
    self.scoreNumber.text = @"9.7分";
}

#pragma mark - setter
- (void)setOptionStartNumber:(NSInteger)optionStartNumber {
    _optionStartNumber = optionStartNumber;
    if (_optionStartNumber > 0 && _optionStartNumber <= 5) {
        for (NSInteger i = 0; i < _optionStartNumber; i++) {
            UIImageView *imageView = [self viewWithTag:10+i];
            imageView.image = [UIImage imageNamed:@"lx_cource_star_selected"];
        }
    }
}
#pragma mark - getter
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameLabel.font = [UIFont boldSystemFontOfSize:17];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
- (UILabel *)phoneNumber {
    if (!_phoneNumber) {
        _phoneNumber = [[UILabel alloc] init];
        _phoneNumber.textColor = [UIColor colorWithHexString:@"#666666"];
        _phoneNumber.textAlignment = NSTextAlignmentLeft;
        _phoneNumber.font = [UIFont systemFontOfSize:14];
    }
    return _phoneNumber;
}
- (UIView *)startFatherView {
    if (!_startFatherView) {
        _startFatherView = [[UIView alloc] init];
        for (NSInteger i = 0; i < 5; i++) {
            UIImageView *startImageView = [[UIImageView alloc] init];
            startImageView.image = [UIImage imageNamed:@"lx_cource_star_normal"];
            startImageView.tag = 10 + i;
            [_startFatherView addSubview:startImageView];
            [self.startArr addObject:startImageView];
        }
    }
    return _startFatherView;
}
- (UILabel *)scoreNumber {
    if (!_scoreNumber) {
        _scoreNumber = [[UILabel alloc] init];
        _scoreNumber.textAlignment = NSTextAlignmentLeft;
        _scoreNumber.textColor = [UIColor colorWithHexString:@"#999999"];
        _scoreNumber.font = [UIFont systemFontOfSize:14];
    }
    return _scoreNumber;
}
- (UIView *)bottomBreakLine {
    if (!_bottomBreakLine) {
        _bottomBreakLine = [[UIView alloc] init];
        _bottomBreakLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _bottomBreakLine;
}
- (NSMutableArray *)startArr {
    if (!_startArr) {
        _startArr = [[NSMutableArray alloc] init];
    }
    return _startArr;
}
@end
