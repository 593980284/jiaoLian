//
//  LXMainMessageHeaderView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMainMessageHeaderView.h"
#import "LXMineModel.h"

@interface LXMainMessageHeaderView ()
/// 背景图
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
/// 证件号
@property (nonatomic, strong) UILabel *credentialsNumber;
/// 姓名+车牌号
@property (nonatomic, strong) UILabel *nameLicenseNumber;
/// 教龄
@property (nonatomic, strong) UILabel *topSchoolAge;
@property (nonatomic, strong) UILabel *bottomSchoolAge;
@property (nonatomic, strong) UIView *firstBreakLine;
/// 学员人数
@property (nonatomic, strong) UILabel *topStudentNumber;
@property (nonatomic, strong) UILabel *bottomStudentNumber;
@property (nonatomic, strong) UIView *secondBreakLine;
/// 驾校名称
@property (nonatomic, strong) UILabel *topDrivingName;
@property (nonatomic, strong) UILabel *bottomDrivingName;

@end

@implementation LXMainMessageHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self subView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width;
    CGFloat h = 168 * kAutoSizeScaleX;
    self.bgImageView.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = 54;
    w = 60*kAutoSizeScaleX;
    h = 60*kAutoSizeScaleX;
    self.headerImageView.frame = CGRectMake(x, y, w, h);
    self.headerImageView.centerY = self.bgImageView.centerY;
    
    x = CGRectGetMaxX(self.headerImageView.frame) + 10;
    y = 69*kAutoSizeScaleX;
    w = self.width - (60*kAutoSizeScaleX+10+15+15);
    h = 12;
    self.credentialsNumber.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.headerImageView.frame) + 11;
    y = CGRectGetMaxY(self.credentialsNumber.frame) + 11;
    w = self.width - (60*kAutoSizeScaleX+11+15+15);
    h = 13;
    self.nameLicenseNumber.frame = CGRectMake(x, y, w, h);
    
    CGFloat averageWidth = self.width / 3.0;
    x = 0;
    y = CGRectGetMaxY(self.bgImageView.frame)+25;
    w = averageWidth;
    h = 17;
    self.topSchoolAge.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = CGRectGetMaxY(self.topSchoolAge.frame) + 14;
    w = averageWidth;
    h = 13;
    self.bottomSchoolAge.frame = CGRectMake(x, y, w, h);
    
    x = averageWidth - .5;
    y = CGRectGetMaxY(self.bgImageView.frame) + 15;
    w = .5;
    h = 60;
    self.firstBreakLine.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.topSchoolAge.frame);
    y = CGRectGetMaxY(self.bgImageView.frame)+25;
    w = averageWidth;
    h = 17;
    self.topStudentNumber.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.topSchoolAge.frame);
    y = CGRectGetMaxY(self.topStudentNumber.frame) + 15;
    w = averageWidth;
    h = 14;
    self.bottomStudentNumber.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.topStudentNumber.frame)-.5;
    y = CGRectGetMaxY(self.bgImageView.frame) + 15;
    w = .5;
    h = 60;
    self.secondBreakLine.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.topStudentNumber.frame) ;
    y = CGRectGetMaxY(self.bgImageView.frame)+25;
    w = averageWidth;
    h = 17;
    self.topDrivingName.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.topStudentNumber.frame) ;
    y = CGRectGetMaxY(self.topDrivingName.frame) + 13;
    w = averageWidth;
    h = 14;
    self.bottomDrivingName.frame = CGRectMake(x, y, w, h);
    
    
}
- (void)subView {
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.headerImageView];
    [self.bgImageView addSubview: self.credentialsNumber];
    [self.bgImageView addSubview:self.nameLicenseNumber];
    [self addSubview:self.topSchoolAge];
    [self addSubview:self.bottomSchoolAge];
    [self addSubview:self.firstBreakLine];
    [self addSubview:self.topStudentNumber];
    [self addSubview:self.bottomStudentNumber];
    [self addSubview:self.secondBreakLine];
    [self addSubview:self.topDrivingName];
    [self addSubview:self.bottomDrivingName];
}

- (void)assignmentMineHeaderValue:(LXMineModel *)headerModel {
    self.credentialsNumber.text = headerModel.phone;
    self.nameLicenseNumber.text = [NSString stringWithFormat:@"%@  %@",headerModel.coachName,headerModel.carNo];
    self.topSchoolAge.text = [NSString stringWithFormat:@"%@年",headerModel.teachAge];
    self.topStudentNumber.text = [NSString stringWithFormat:@"%@",headerModel.studentNum];
    self.topDrivingName.text = [NSString stringWithFormat:@"%@",headerModel.schoolName];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:headerModel.photo] placeholderImage:[UIImage imageNamed:@"lx_header_placeholder"]];
    
}

#pragma mark - Gesture
- (void)headerViewTapGesture {
    self.clickHeadActionBlock();
}
#pragma mark - getter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.image = [UIImage imageNamed:@"lx_mine_message_bgpic"];
    }
    return _bgImageView;
}
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _headerImageView.layer.cornerRadius = 60*kAutoSizeScaleX/2;
        _headerImageView.clipsToBounds = YES;
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewTapGesture)];
        [_headerImageView addGestureRecognizer:tapGesture];
    }
    return _headerImageView;
}
- (UILabel *)credentialsNumber {
    if (!_credentialsNumber) {
        _credentialsNumber = [[UILabel alloc] init];
        _credentialsNumber.font = [UIFont systemFontOfSize:15];
        _credentialsNumber.textColor = [UIColor whiteColor];
        _credentialsNumber.textAlignment = NSTextAlignmentLeft;
    }
    return _credentialsNumber;
}
- (UILabel *)nameLicenseNumber {
    if (!_nameLicenseNumber) {
        _nameLicenseNumber = [[UILabel alloc] init];
        _nameLicenseNumber.font = [UIFont systemFontOfSize:14];
        _nameLicenseNumber.textAlignment = NSTextAlignmentLeft;
        _nameLicenseNumber.textColor = [UIColor whiteColor];
    }
    return _nameLicenseNumber;
}
- (UILabel *)topSchoolAge {
    if (!_topSchoolAge) {
        _topSchoolAge = [[UILabel alloc] init];
        _topSchoolAge.font = [UIFont systemFontOfSize:18];
        _topSchoolAge.textColor = [UIColor colorWithHexString:@"#333333"];
        _topSchoolAge.textAlignment = NSTextAlignmentCenter;
    }
    return _topSchoolAge;
}
- (UILabel *)bottomSchoolAge {
    if (!_bottomSchoolAge) {
        _bottomSchoolAge = [[UILabel alloc] init];
        _bottomSchoolAge.textAlignment = NSTextAlignmentCenter;
        _bottomSchoolAge.textColor = [UIColor colorWithHexString:@"#999999"];
        _bottomSchoolAge.font = [UIFont systemFontOfSize:14];
        _bottomSchoolAge.text = @"教龄";
    }
    return _bottomSchoolAge;
}
- (UIView *)firstBreakLine {
    if (!_firstBreakLine) {
        _firstBreakLine = [[UIView alloc] init];
        _firstBreakLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _firstBreakLine;
}
- (UILabel *)topStudentNumber {
    if (!_topStudentNumber) {
        _topStudentNumber = [[UILabel alloc] init];
        _topStudentNumber.font = [UIFont systemFontOfSize:18];
        _topStudentNumber.textAlignment = NSTextAlignmentCenter;
        _topStudentNumber.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _topStudentNumber;
}
- (UILabel *)bottomStudentNumber {
    if (!_bottomStudentNumber) {
        _bottomStudentNumber = [[UILabel alloc] init];
        _bottomStudentNumber.font = [UIFont systemFontOfSize:14];
        _bottomStudentNumber.textAlignment = NSTextAlignmentCenter;
        _bottomStudentNumber.textColor = [UIColor colorWithHexString:@"#999999"];
        _bottomStudentNumber.text = @"当前学生数";
    }
    return _bottomStudentNumber;
}
- (UIView *)secondBreakLine {
    if (!_secondBreakLine) {
        _secondBreakLine = [[UIView alloc] init];
        _secondBreakLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _secondBreakLine;
}
- (UILabel *)topDrivingName {
    if (!_topDrivingName) {
        _topDrivingName = [[UILabel alloc] init];
        _topDrivingName.font = [UIFont systemFontOfSize:18];
        _topDrivingName.textAlignment = NSTextAlignmentCenter;
        _topDrivingName.textColor = [UIColor colorWithHexString:@"#333333"];
        _topDrivingName.adjustsFontSizeToFitWidth = YES;
    }
    return _topDrivingName;
}
- (UILabel *)bottomDrivingName {
    if (!_bottomDrivingName) {
        _bottomDrivingName = [[UILabel alloc] init];
        _bottomDrivingName.textAlignment = NSTextAlignmentCenter;
        _bottomDrivingName.font = [UIFont systemFontOfSize:14];
        _bottomDrivingName.textColor = [UIColor colorWithHexString:@"999999"];
        _bottomDrivingName.text = @"驾校";
    }
    return _bottomDrivingName;
}
@end
