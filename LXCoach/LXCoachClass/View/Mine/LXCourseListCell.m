//
//  LXCourseListCell.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/7.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseListCell.h"
#import "LXFindCourseRecordModel.h"

@interface LXCourseListCell ()
/// 头像
@property (nonatomic, strong) UIImageView *headerImageView;
/// 科目几 / 姓名
@property (nonatomic, strong) UILabel *subjectNumber;
/// 驾校名称
@property (nonatomic, strong) UILabel *drivingSchoolName;
/// 时间
@property (nonatomic, strong)  UILabel *time;
/// 学员人数 缺课人数
@property (nonatomic, strong) UILabel *studentState;
/// 分割线
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation LXCourseListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.subjectNumber];
//        [self.contentView addSubview:self.borderSubjectAge];
        [self.contentView addSubview:self.drivingSchoolName];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview: self.studentState];
        [self.contentView addSubview:self.bottomLine];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = 15;
    CGFloat w = 70 *kAutoSizeScaleX;
    CGFloat h = 70 *kAutoSizeScaleX;
    self.headerImageView.frame = CGRectMake(x, y, w, h);
    self.headerImageView.centerY = self.contentView.centerY;
    
    x = CGRectGetMaxX(self.headerImageView.frame) + 10;
    y = 19;
    w = 150;
    h = 15;
    self.subjectNumber.frame = CGRectMake(x, y, w, h);
    
//    x = CGRectGetMaxX(self.subjectNumber.frame) + 15;
//    y = 19;
//    w = 98;
//    h = 15;
//    self.borderSubjectAge.frame = CGRectMake(x, y, w, h);

    x = self.width - (16+100);
    y = 22;
    w = 100;
    h = 12;
    self.drivingSchoolName.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.headerImageView.frame) + 10;
    y = CGRectGetMaxY(self.subjectNumber.frame) + 10;
    w = self.width - (15+10+70 *kAutoSizeScaleX+15);
    h = 9;
    self.time.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.headerImageView.frame) + 10;
    y = CGRectGetMaxY(self.time.frame) + 12;
    w = self.width - (15+10+70 *kAutoSizeScaleX+15);
    h = 12;
    self.studentState.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = self.height - .5;
    w = self.width;
    h = .5;
    self.bottomLine.frame = CGRectMake(x, y, w, h);
    
}
- (void)valueToSubView {
    self.subjectNumber.text = @"科目一";
    self.drivingSchoolName.text = @"小白驾校";
    self.time.text = @"2018-05-28   14:00:00-16:00:00";
    self.studentState.text = @"学员：3人   缺课人员：0人";
}

#pragma mark - publicMethod
- (void)configCellValue:(LXFindCourseRecordModel *)model {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.coachPhoto]];
    self.subjectNumber.text = model.subjectName;
    self.drivingSchoolName.text = model.schoolName;
    self.time.text = model.periodTime;
    if (model.courseState == 0) {
        self.studentState.text = [NSString stringWithFormat:@"学员：%ld人     缺课人员：%ld人",(long)model.reachStuNum,(long)model.noReachStuNum];
    }else if (model.courseState == 1) {
        self.studentState.text = [NSString stringWithFormat:@"学员：%ld     学时：%ld学时",(long)model.reachStuNum,(long)model.hours];
    }
    
}

#pragma mark - getter
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _headerImageView.layer.cornerRadius = 70 *kAutoSizeScaleX/2;
    }
    return _headerImageView;
}
- (UILabel *)subjectNumber {
    if (!_subjectNumber) {
        _subjectNumber = [[UILabel alloc] init];
        _subjectNumber.textAlignment = NSTextAlignmentLeft;
        _subjectNumber.font = [UIFont systemFontOfSize:16];
        _subjectNumber.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _subjectNumber;
}
//- (UILabel *)borderSubjectAge {
//    if (!_borderSubjectAge) {
//        _borderSubjectAge = [[UILabel alloc] init];
//        _borderSubjectAge.layer.borderWidth = .5;
//        _borderSubjectAge.layer.borderColor = [UIColor colorWithHexString:@"#333333"].CGColor;
//        _borderSubjectAge.layer.cornerRadius = 3;
//        _borderSubjectAge.textAlignment = NSTextAlignmentCenter;
//        _borderSubjectAge.font = [UIFont systemFontOfSize:12];
//        _borderSubjectAge.textColor = [UIColor colorWithHexString:@"#333333"];
//    }
//    return _borderSubjectAge;
//}
- (UILabel *)drivingSchoolName {
    if (!_drivingSchoolName) {
        _drivingSchoolName = [[UILabel alloc] init];
        _drivingSchoolName.textColor = [UIColor colorWithHexString:@"#333333"];
        _drivingSchoolName.textAlignment = NSTextAlignmentRight;
        _drivingSchoolName.font = [UIFont systemFontOfSize:12];
    }
    return _drivingSchoolName;
}
- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor colorWithHexString:@"#333333"];
        _time.textAlignment = NSTextAlignmentLeft;
        _time.font = [UIFont systemFontOfSize:12];
    }
    return _time;
}
- (UILabel *)studentState {
    if (!_studentState) {
        _studentState = [[UILabel alloc] init];
        _studentState.font = [UIFont systemFontOfSize:12];
        _studentState.textColor = [UIColor colorWithHexString:@"#333333"];
        _studentState.textAlignment = NSTextAlignmentLeft;
    }
    return _studentState;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _bottomLine;
}

@end
