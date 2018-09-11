//
//  LXCourseEvaluateView.m
//  LXCoach
//
//  Created by GDD on 2018/9/10.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseEvaluateView.h"
#import "LXCourseDetailHeadView.h"
#import "LXCourseListModel.h"
@interface LXCourseEvaluateView ()<UITextViewDelegate>
@property (nonatomic, strong) LXCourseDetailHeadView *headView;
/// 本次学员评价课程
@property (nonatomic, strong) UILabel *studentCourceLabel;
/// 姓名
@property (nonatomic, strong) UILabel *nameLabel;
/// 星星的父视图
@property (nonatomic, strong) UIView * startFatherView;
/// placeholderLabel
@property (nonatomic, strong) UILabel *placeholderLabel;
/// 评价输入
@property (nonatomic, strong) UITextView *assessTextView;
/// 下一步
@property (nonatomic, strong) UIButton *nextStepButton;

@property (nonatomic, strong) NSMutableArray *startArr;

@end

@implementation LXCourseEvaluateView

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = CGRectGetMaxY(self.headView.frame)+15;
    CGFloat w = 200;
    CGFloat h = 14;
    self.studentCourceLabel.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.studentCourceLabel.frame)+25;
    w = 60;
    h = 17;
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.nameLabel.frame)+15;
    y = CGRectGetMaxY(self.studentCourceLabel.frame)+24;
    w = 15*kAutoSizeScaleX * 5 + 4 * 5;
    h = 15*kAutoSizeScaleX;
    self.startFatherView.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.nameLabel.frame)+22;
    w = self.width - 30;
    h = self.height-(CGRectGetMaxY(self.nameLabel.frame)+22+135);
    self.assessTextView.frame = CGRectMake(x, y, w, h);
    
    x = 5;
    y = 8;
    w = self.width - 30;
    h = 14;
    self.placeholderLabel.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = self.height-(15+45);
    w = self.width - 30;
    h = 45;
    self.nextStepButton.frame = CGRectMake(x, y, w, h);
}
- (void)createUI {
    [self addSubview:self.headView];
    self.headView.courseListModel = [LXCourseListModel new];
    
    [self addSubview:self.studentCourceLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.startFatherView];
    [self.startArr enumerateObjectsUsingBlock:^(UIImageView  *imageViewObj, NSUInteger idx, BOOL * _Nonnull stop) {
        imageViewObj.frame = CGRectMake((15*kAutoSizeScaleX+5) * idx , 0, 15*kAutoSizeScaleX, 15*kAutoSizeScaleX);
    }];
    [self addSubview:self.assessTextView];
    [self.assessTextView addSubview:self.placeholderLabel];
    [self addSubview:self.nextStepButton];
}

#pragma mark - Event
- (void)nextStepButtonAction {
    if ([self.delegate respondsToSelector:@selector(lx_courseAssessNextStep:)]) {
        [self.delegate lx_courseAssessNextStep:self.assessTextView.text];
    }
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.placeholderLabel.text = @"";
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        _placeholderLabel.text = @"请输入学员的课程评价";
    }
    return YES;
}

#pragma mark - getter
- (LXCourseDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[LXCourseDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 135)];
    }
    return _headView;
}
- (UILabel *)studentCourceLabel {
    if (!_studentCourceLabel) {
        _studentCourceLabel = [[UILabel alloc] init];
        _studentCourceLabel.font = [UIFont systemFontOfSize:14];
        _studentCourceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _studentCourceLabel.text = @"本次学员评价课程";
    }
    return _studentCourceLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _nameLabel.text = @"张三";
    }
    return _nameLabel;
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
- (UITextView *)assessTextView {
    if (!_assessTextView) {
        _assessTextView = [[UITextView alloc] init];
        _assessTextView.textColor = [UIColor colorWithHexString:@"#999999"];
        _assessTextView.font = [UIFont systemFontOfSize:14];
        _assessTextView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _assessTextView.layer.borderWidth = .5;
        _assessTextView.delegate = self;
    }
    return _assessTextView;
}
- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.text = @"请输入学员的课程评价";
        _placeholderLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
    }
    return _placeholderLabel;
}
- (UIButton *)nextStepButton {
    if (!_nextStepButton) {
        _nextStepButton = [[UIButton alloc] init];
        [_nextStepButton setBackgroundColor:[UIColor colorWithHexString:@"#309CF5"]];
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextStepButton.layer.cornerRadius = 5;
        _nextStepButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_nextStepButton addTarget:self action:@selector(nextStepButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}
- (NSMutableArray *)startArr {
    if (!_startArr) {
        _startArr = [[NSMutableArray alloc] init];
    }
    return _startArr;
}
@end
