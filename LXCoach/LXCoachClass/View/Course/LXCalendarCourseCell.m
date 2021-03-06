//
//  LXCalendarCourseCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/14.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCalendarCourseCell.h"
#import "LXCourseFindDateListModel.h"

@interface LXCalendarCourseCell ()
/// 星期
@property (nonatomic, strong) UILabel *weekLabel;
/// 有预约显示的点
@property (nonatomic, strong) UILabel *reservationLabel;
@end

@implementation LXCalendarCourseCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.weekLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.reservationLabel];
        [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
        }];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-21);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(27);
        }];
        [_reservationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.dateLabel.mas_bottom);
        }];
    }
    return self;
}
#pragma mark - publicMethod
- (void)congfigCourseFindDateListModel:(LXCourseFindDateListModel *)model {
    self.weekLabel.text = model.week;
    self.dateLabel.text = model.oneDate;
    if (model.firstIsOption == 1) {
        _dateLabel.backgroundColor = [UIColor colorWithRed:212/255.0 green:231/255.0 blue:255/255.0 alpha:1];
        _dateLabel.textColor = TEXT_COLOR_GRAY;
    }else {
        _dateLabel.backgroundColor = [UIColor whiteColor];
        _dateLabel.textColor = TEXT_COLOR_BLACK;
    }
    if (model.has == 1) {
        self.dateLabel.textColor = [UIColor colorWithRed:123/255.0 green:192/255.0 blue:100/255.0 alpha:1];
        self.reservationLabel.hidden = NO;
    }else {
        self.reservationLabel.hidden = YES;
    }
}

#pragma mark - getter
- (UILabel *)weekLabel {
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc] init];
        _weekLabel.textColor = TEXT_COLOR_GRAY;
        _weekLabel.textAlignment = NSTextAlignmentCenter;
        _weekLabel.font = [UIFont systemFontOfSize:12];
    }
    return _weekLabel;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.clipsToBounds = YES;
        _dateLabel.layer.cornerRadius =  13.5;
    }
    return _dateLabel;
}
- (UILabel *)reservationLabel {
    if (!_reservationLabel) {
        _reservationLabel = [[UILabel alloc] init];
        _reservationLabel.textAlignment = NSTextAlignmentCenter;
        _reservationLabel.font = [UIFont systemFontOfSize:12];
        _reservationLabel.textColor = [UIColor colorWithRed:123/255.0 green:192/255.0 blue:100/255.0 alpha:1];
        _reservationLabel.text = @"已排课";
        _reservationLabel.hidden = YES;
    }
    return _reservationLabel;
}
@end
