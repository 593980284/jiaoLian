//
//  LXMainMessageHeaderView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMainMessageHeaderView.h"
#import "LXMineModel.h"
#import "LXUrlApi.h"

@interface LXMainMessageHeaderView ()
/// 背景图
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
/// 车牌号
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

- (void)subView {
    [self addSubview:self.bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-65*kAutoSizeScaleX);
        make.left.right.top.equalTo(self);
    }];
    
    [self.bgImageView addSubview:self.headerImageView];
    [self.bgImageView addSubview:self.nameLicenseNumber];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(LXNavigationStatusBar);make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(76*kAutoSizeScaleX, 76*kAutoSizeScaleX));
    }];
    [_nameLicenseNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_bottom).offset(11*kAutoSizeScaleX);
        make.left.right.equalTo(self);
    }];
    
    UIView *tempView = [UIView new];
    tempView.backgroundColor = [UIColor whiteColor];
    tempView.layer.cornerRadius = 8.0;
    tempView.layer.shadowColor = [UIColor blackColor].CGColor;
    tempView.layer.shadowOffset = CGSizeMake(2, 2);
    tempView.layer.shadowRadius = 8.0;
    tempView.layer.shadowOpacity = 0.2;
    [self addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);make.left.equalTo(self).offset(18);make.right.equalTo(self).offset(-18);
        make.height.mas_equalTo(85 * kAutoSizeScaleX);
    }];
    [tempView addSubview:self.topSchoolAge];
    [tempView addSubview:self.bottomSchoolAge];
    [tempView addSubview:self.firstBreakLine];
    [tempView addSubview:self.topStudentNumber];
    [tempView addSubview:self.bottomStudentNumber];
    [tempView addSubview:self.secondBreakLine];
    [tempView addSubview:self.topDrivingName];
    [tempView addSubview:self.bottomDrivingName];
    
    [_firstBreakLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tempView.mas_right).multipliedBy(1/3.0);
        make.centerY.equalTo(tempView);
        make.size.mas_equalTo(CGSizeMake(0.5, 33));
    }];
    [_secondBreakLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tempView.mas_right).multipliedBy(2/3.0);
        make.centerY.equalTo(tempView);
        make.size.mas_equalTo(CGSizeMake(0.5, 33));
    }];
    
    [_topSchoolAge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tempView.mas_centerY).offset(-6);
        make.left.equalTo(tempView);make.right.equalTo(self.firstBreakLine.mas_left);
    }];
    [_bottomSchoolAge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tempView.mas_centerY).offset(6);
        make.left.right.equalTo(self.topSchoolAge);
    }];
    
    [_topStudentNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstBreakLine.mas_right);
        make.right.equalTo(self.secondBreakLine.mas_left);
        make.centerY.equalTo(self.topSchoolAge);
    }];
    [_bottomStudentNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topStudentNumber);
        make.centerY.equalTo(self.bottomSchoolAge);
    }];

    [_topDrivingName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondBreakLine.mas_right);make.right.equalTo(tempView);
        make.centerY.equalTo(self.topSchoolAge);
    }];

    [_bottomDrivingName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topDrivingName);
        make.centerY.equalTo(self.bottomSchoolAge);
    }];
}

- (void)assignmentMineHeaderValue:(LXMineModel *)headerModel {
    self.nameLicenseNumber.text = [NSString stringWithFormat:@"%@",headerModel.carNo];
    self.topSchoolAge.text = [NSString stringWithFormat:@"%@年",headerModel.teachAge];
    self.topStudentNumber.text = [NSString stringWithFormat:@"%@位",headerModel.studentNum];
    self.topDrivingName.text = [NSString stringWithFormat:@"%@",headerModel.schoolName];    
    NSString *imageUrl = [kBaseImageUrl stringByAppendingPathComponent:headerModel.photo];
    [self.headerImageView lx_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_header_placeholder"]];
    
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
        _headerImageView.layer.cornerRadius = 76*kAutoSizeScaleX/2;
        _headerImageView.clipsToBounds = YES;
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewTapGesture)];
        [_headerImageView addGestureRecognizer:tapGesture];
    }
    return _headerImageView;
}
- (UILabel *)nameLicenseNumber {
    if (!_nameLicenseNumber) {
        _nameLicenseNumber = [[UILabel alloc] init];
        _nameLicenseNumber.font = [UIFont systemFontOfSize:16];
        _nameLicenseNumber.textAlignment = NSTextAlignmentCenter;
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
