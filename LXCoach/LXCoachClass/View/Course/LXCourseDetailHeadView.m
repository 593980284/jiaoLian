//
//  LXCourseDetailHeadView.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseDetailHeadView.h"
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "LXCourseDetailModel.h"
#import "LXUrlApi.h"

@interface LXCourseDetailHeadView()

@property (nonatomic, strong) FLAnimatedImageView *leftImageView;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation LXCourseDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 15;
    CGFloat y = 15;
    CGFloat w = 64;
    CGFloat h = 64;
    self.leftImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.leftImageView.frame)+10;
    y = 20;
    w = kScreenWidth-x-15;
    h = 16;
    self.subjectLabel.frame = CGRectMake(x, y, w, h);
}

- (void)createUI {
    [self addSubview:self.leftImageView];
    [self addSubview:self.subjectLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.numberLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.bottom.equalTo(self.numberLabel.mas_top).offset(-4);
        make.right.equalTo(self);
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.bottom.equalTo(self.leftImageView);
        make.right.equalTo(self);
    }];
}

#pragma mark - setter
- (void)setCourseListModel:(LXCourseDetailModel *)courseListModel {
    _courseListModel = courseListModel;
    
    NSInteger subjectId = courseListModel.subjectId ;
    UIImage *sImg = [UIImage imageNamed:@"lx_kemu_1"];
    if (subjectId == 2) {
        sImg = [UIImage imageNamed:@"lx_kemu_2"];
    }else if (subjectId == 3){
        sImg = [UIImage imageNamed:@"lx_kemu_3"];
    }else if (subjectId == 4){
        sImg = [UIImage imageNamed:@"lx_kemu_4"];
    }
    _leftImageView.image = sImg;
    self.subjectLabel.text = _courseListModel.subjectName;
    self.timeLabel.text = _courseListModel.periodTime;
    _numberLabel.text = [NSString stringWithFormat:@"%@ | 已约课%ld/%ld | 已取消%ld",courseListModel.className,courseListModel.appointmentNum,courseListModel.maxNum,courseListModel.cancelNum];
}

#pragma mark - getter
- (FLAnimatedImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[FLAnimatedImageView alloc]init];
        _leftImageView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
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


@end
