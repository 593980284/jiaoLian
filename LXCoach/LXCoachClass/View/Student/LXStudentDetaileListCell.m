//
//  LXStudentDetaileListCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentDetaileListCell.h"
#import "LXStudentSubjectDetailModel.h"

@interface LXStudentDetaileListCell ()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@end

@implementation LXStudentDetaileListCell

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
    CGFloat y = 0;
    CGFloat w = self.contentView.width / 3;
    CGFloat h = 11;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.dateLabel.frame);
    y = 0;
    w = self.contentView.width / 3;
    h = 11;
    self.timeLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.timeLabel.frame);
    y = 0;
    w = self.contentView.width / 3;
    h = 13;
    self.stateLabel.frame = CGRectMake(x, y, w, h);
}

#pragma mark - publicMethod
- (void)configStudentSubjectDetailModel:(LXStudentSubjectDetailModel *)model {
    self.dateLabel.text = model.date;
    self.timeLabel.text = model.time;
    if (model.status == 2 || model.status == 6) {
        _stateLabel.text = @"已到";
    }else if (model.status == 3 || model.status == 7) {
        _stateLabel.text = @"缺勤";
    }else if (model.status == 1 || model.status == 4 || model.status == 5) {
        _stateLabel.text = @"未确认";
    }else if (model.status == 10) {
        _stateLabel.text = @"已取消";
    }
}

#pragma mark - getter
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _stateLabel.font = [UIFont systemFontOfSize:14];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}
@end
