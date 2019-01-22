//
//  LXHandleCalendarItemCell.m
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXHandleCalendarItemCell.h"
@interface LXHandleCalendarItemCell ()
/// 星期
@property (nonatomic, strong) UILabel *weekLabel;
/// 日期
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation LXHandleCalendarItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.weekLabel];
        [self addSubview:self.dateLabel];
        [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.dateLabel.mas_top).offset(-8);
        }];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-8);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(27);
        }];
    }
    return self;
}
#pragma mark - publicMethod
- (void)congfigCourseFindDateListModel:(LXAffairsDateModel *)model {
    self.weekLabel.text = model.week;
    self.dateLabel.text = model.oneDate;
    if (model.firstIsOption == 1) {
        _dateLabel.backgroundColor = [UIColor colorWithRed:212/255.0 green:231/255.0 blue:255/255.0 alpha:1];
        _dateLabel.textColor = TEXT_COLOR_GRAY;
    }else {
        _dateLabel.backgroundColor = [UIColor whiteColor];
        _dateLabel.textColor = TEXT_COLOR_BLACK;
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
@end
