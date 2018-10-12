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
@property (nonatomic, strong) UIView *reservationView;
@end

@implementation LXCalendarCourseCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.weekLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.reservationView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 32;
    CGFloat w = self.contentView.width;
    CGFloat h = 15;
    self.weekLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = CGRectGetMaxY(self.weekLabel.frame)+10;
    w = 30;
    h = 30;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    self.dateLabel.centerX = self.contentView.centerX;
    
    x = 0 ;
    y = CGRectGetMaxY(self.dateLabel.frame) + 2;
    w = 8;
    h = 8;
    self.reservationView.frame = CGRectMake(x, y, w, h);
    self.reservationView.centerX = self.contentView.centerX;
    
}
#pragma mark - publicMethod
- (void)congfigCourseFindDateListModel:(LXCourseFindDateListModel *)model {
    self.weekLabel.text = model.week;
    self.dateLabel.text = model.oneDate;
    if (model.has == 1) {
        self.reservationView.hidden = NO;
    }else {
        self.reservationView.hidden = YES;
    }
}

#pragma mark - getter
- (UILabel *)weekLabel {
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc] init];
        _weekLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _weekLabel.textAlignment = NSTextAlignmentCenter;
        _weekLabel.font = [UIFont systemFontOfSize:16];
    }
    return _weekLabel;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:16];
        _dateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dateLabel.clipsToBounds = YES;
        _dateLabel.layer.cornerRadius =  15;
//        _dateLabel.backgroundColor = [UIColor colorWithHexString:@"#309CF5"];
    }
    return _dateLabel;
}
- (UIView *)reservationView {
    if (!_reservationView) {
        _reservationView = [[UIView alloc] init];
        _reservationView.backgroundColor = [UIColor colorWithHexString:@"#FEAE3C"];
        _reservationView.layer.cornerRadius = 4;
        _reservationView.hidden = YES;
    }
    return _reservationView;
}
@end
