//
//  LXCourseDetailCell.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseDetailCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import "LXCourseDetailModel.h"
#import "LXUrlApi.h"
@interface LXCourseDetailCell()

@property (nonatomic, strong) FLAnimatedImageView *leftImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *subjectNameLabel;
/// 评分
@property (nonatomic, strong) UILabel *studentScoreLabel;
@property (nonatomic, strong) UIView *lineView;
/// 星星的父视图
@property (nonatomic, strong) UIView * startFatherView;

@property (nonatomic, strong) NSMutableArray *startArr;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@end


@implementation LXCourseDetailCell

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
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.nameLabel.frame);
    y = CGRectGetMaxY(self.nameLabel.frame)+15;
    w = 120;
    h = 13;
    self.subjectNameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.nameLabel.frame);
    y = CGRectGetMaxY(self.subjectNameLabel.frame)+ 10;
    w = 15*kAutoSizeScaleX * 5 + 4 * 5;
    h = 15*kAutoSizeScaleX;
    self.startFatherView.frame = CGRectMake(x, y, w, h);
    
    [self.startArr enumerateObjectsUsingBlock:^(UIImageView  *imageViewObj, NSUInteger idx, BOOL * _Nonnull stop) {
        imageViewObj.frame = CGRectMake((15*kAutoSizeScaleX+5) * idx , 0, 15*kAutoSizeScaleX, 15*kAutoSizeScaleX);
    }];
    
    x = CGRectGetMaxX(self.startFatherView.frame)+10;
    y = CGRectGetMaxY(self.subjectNameLabel.frame)+11;
    w = 45;
    h = 13;
    self.studentScoreLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = CGRectGetMaxY(self.leftImageView.frame)+14;
    w = kScreenWidth;
    h = 1;
    self.lineView.frame = CGRectMake(x, y, w, h);
    
    x = self.contentView.width - (15 + 75);
    y = 15;
    w = 75;
    h = 30;
    self.button1.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.button1.frame) - (8+75);
    y = 15;
    w = 75;
    h = 30;
    self.button2.frame = CGRectMake(x, y, w, h);
}

- (void)createUI {
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.subjectNameLabel];
    [self.contentView addSubview:self.startFatherView];
    [self.contentView addSubview:self.studentScoreLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.button1];
    [self.contentView addSubview:self.button2];
}

#pragma mark - Event
- (void)button1Action:(UIButton *)button {
    self.studentOperationBtn1Block();
}

- (void)button2Action:(UIButton *)button {
    self.studentOperationBtn2Block();
}

#pragma mark - setter
- (void)setCourseStudentModel:(LXCourseToStudentModel *)courseStudentModel {
    _courseStudentModel = courseStudentModel;
    NSString *imageUrl = [kBaseImageUrl stringByAppendingPathComponent:self.courseStudentModel.studentPhoto];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_placeholder_image"]];
    self.nameLabel.text = self.courseStudentModel.studentName;
    self.subjectNameLabel.text = [NSString stringWithFormat:@"%@  %ld学时",self.courseStudentModel.subjectName, (long)self.courseStudentModel.hours];
    self.studentScoreLabel.text = self.courseStudentModel.studentScore;
    // 根据status来判断显示的按钮
    if (courseStudentModel.status == 0) {
        // 已预约（显示状态）
        self.button2.hidden = YES;
        self.button1.hidden = NO;
        self.button1.enabled = NO;
        [self.button1 setTitle:@"已预约" forState:UIControlStateNormal];
        [self.button1 setBackgroundColor:[UIColor colorWithHexString:@"#999999"]];
        
    }else if (courseStudentModel.status == 1 || courseStudentModel.status == 4) {
        // 1 学员点击了签到（显示已到、缺勤按钮） 4 学员未点击签到（显示已到、缺勤按钮）
        self.button1.hidden = NO;
        self.button2.hidden = NO;
        self.button1.enabled = YES;
        self.button2.enabled = YES;
        [self.button1 setTitle:@"缺勤" forState:UIControlStateNormal];
        [self.button1 setBackgroundColor:[UIColor colorWithHexString:@"#FF3F3F"]];
        [self.button2 setTitle:@"已到" forState:UIControlStateNormal];
        [self.button2 setBackgroundColor:[UIColor colorWithHexString:@"#35B2ED"]];
        
    }else if (courseStudentModel.status == 2  || courseStudentModel.status == 6) {
        // 已到（显示状态）
        self.button2.hidden = YES;
        self.button1.hidden = NO;
        self.button1.enabled = NO;
        [self.button1 setTitle:@"已到" forState:UIControlStateNormal];
        [self.button1 setBackgroundColor:[UIColor colorWithHexString:@"#999999"]];
    }else if (courseStudentModel.status == 3 || courseStudentModel.status == 7) {
        // 缺勤（显示状态）
        self.button2.hidden = YES;
        self.button1.hidden = NO;
        self.button1.enabled = NO;
        [self.button1 setTitle:@"缺勤" forState:UIControlStateNormal];
        [self.button1 setBackgroundColor:[UIColor colorWithHexString:@"#999999"]];
    }else if (courseStudentModel.status == 5) {
        // 未确认（显示状态）
        self.button2.hidden = YES;
        self.button1.hidden = NO;
        self.button1.enabled = NO;
        [self.button1 setTitle:@"未确认" forState:UIControlStateNormal];
        [self.button1 setBackgroundColor:[UIColor colorWithHexString:@"#999999"]];
    }
}

- (void)setOptionStartNumber:(NSInteger)optionStartNumber {
    _optionStartNumber = optionStartNumber;
    if (_optionStartNumber > 0 && _optionStartNumber <= 5) {
        for (NSInteger i = 0; i < _optionStartNumber; i++) {
            UIImageView *imageView = [self viewWithTag:10+i];
            imageView.image = [UIImage imageNamed:@"lx_cource_star_selected"];
        }
    }
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)subjectNameLabel {
    if (!_subjectNameLabel) {
        _subjectNameLabel = [[UILabel alloc]init];
        _subjectNameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _subjectNameLabel.font = [UIFont systemFontOfSize:14];
        _subjectNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _subjectNameLabel;
}

- (UIView *)startFatherView {
    if (!_startFatherView) {
        _startFatherView = [[UIView alloc] init];
        for (NSInteger i = 0; i < 5; i++) {
            UIImageView *startImageView = [[UIImageView alloc] init];
            startImageView.image = [UIImage imageNamed:@"lx_cource_star_normal"];
            startImageView.tag = 10 + i;
            [_startFatherView addSubview:startImageView];
            [self.startArr addObject:startImageView];
        }
    }
    return _startFatherView;
}

- (UILabel *)studentScoreLabel {
    if (!_studentScoreLabel) {
        _studentScoreLabel = [[UILabel alloc]init];
        _studentScoreLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _studentScoreLabel.font = [UIFont systemFontOfSize:14];
        _studentScoreLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _studentScoreLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    }
    return _lineView;
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [[UIButton alloc] init];
        _button1.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
        _button1.layer.cornerRadius = 5;
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [[UIButton alloc] init];
        _button2.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
        _button2.layer.cornerRadius = 5;
    }
    return _button2;
}

- (NSMutableArray *)startArr {
    if (!_startArr) {
        _startArr = [[NSMutableArray alloc] init];
    }
    return _startArr;
}
@end
