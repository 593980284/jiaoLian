//
//  LXCourseCell.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import "LXCourseListModel.h"

@interface LXCourseCell()
@property (nonatomic, strong) FLAnimatedImageView *leftImageView;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LXCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 15;
    CGFloat y = 15;
    CGFloat w = 100;
    CGFloat h = 80;
    self.leftImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.leftImageView.frame)+10;
    y = 20;
    w = kScreenWidth-x-15;
    h = 16;
    self.subjectLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.subjectLabel.frame);
    y = CGRectGetMaxY(self.subjectLabel.frame)+15;
    w = kScreenWidth-x-15;
    h = 13;
    self.numberLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.subjectLabel.frame);
    y = CGRectGetMaxY(self.numberLabel.frame)+15;
    w = kScreenWidth-x-15;
    h = 11;
    self.timeLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = CGRectGetMaxY(self.leftImageView.frame)+14;
    w = kScreenWidth;
    h = 1;
    self.lineView.frame = CGRectMake(x, y, w, h);
}

- (void)createUI {
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.subjectLabel];
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];
}

#pragma mark - setter
- (void)setCourseListModel:(LXCourseListModel *)courseListModel {
    _courseListModel = courseListModel;
//    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:courseListModel] placeholderImage:nil];
    self.subjectLabel.text = self.courseListModel.subjectName;
    self.numberLabel.text = [NSString stringWithFormat:@"报名 %ld       剩余 %ld",(long)self.courseListModel.appointmentNum, (long)self.courseListModel.noAppointmentNum];
    self.timeLabel.text = self.courseListModel.periodTime;
}

#pragma mark - getter
- (FLAnimatedImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[FLAnimatedImageView alloc]init];
        _leftImageView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    }
    return _leftImageView;
}

- (UILabel *)subjectLabel {
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc]init];
        _subjectLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _subjectLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _subjectLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _subjectLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _numberLabel.font = [UIFont systemFontOfSize:14];
        _numberLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _numberLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    }
    return _lineView;
}
@end
