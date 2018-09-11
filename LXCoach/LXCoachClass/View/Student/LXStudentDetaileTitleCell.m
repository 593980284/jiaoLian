//
//  LXStudentDetaileTitleCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentDetaileTitleCell.h"

@interface LXStudentDetaileTitleCell ()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@end

@implementation LXStudentDetaileTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.stateLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x =  0;
    CGFloat y = 16;
    CGFloat w = self.contentView.width / 3;
    CGFloat h = 15;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.dateLabel.frame);
    y = 16;
    w = self.contentView.width / 3;
    h = 15;
    self.timeLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.timeLabel.frame);
    y = 16;
    w = self.contentView.width / 3;
    h = 15;
    self.stateLabel.frame = CGRectMake(x, y, w, h);
}
#pragma mark - getter
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _dateLabel.font = [UIFont systemFontOfSize:16];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = @"日期";
    }
    return _dateLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _timeLabel.font = [UIFont systemFontOfSize:16];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"时间";
    }
    return _timeLabel;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _stateLabel.font = [UIFont systemFontOfSize:16];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.text = @"状态";
    }
    return _stateLabel;
}
@end
