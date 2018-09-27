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
#import "LXCourseDetailModel.h"
#import "LXSearchCourseRecordJudgeModel.h"

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
/// 存储星星view的Arr
@property (nonatomic, strong) NSMutableArray *startArr;
/// 约课记录id Arr
@property (nonatomic, strong) NSMutableArray *courseRecordIdsArr;
/// 课程评价分数Arr
@property (nonatomic, strong) NSMutableArray *studentScoresArr;
/// 课程评价内容Arr
@property (nonatomic, strong) NSMutableArray *studentEvaluationContentsArr;
@end

@implementation LXCourseEvaluateView
{
    /// 评价的分数
    NSInteger _score;
    /// 记录当前是第几个评价
    NSInteger _recordCurrentIndex;
}
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
    w = 80;
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
    [self addSubview:self.studentCourceLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.startFatherView];
    [self.startArr enumerateObjectsUsingBlock:^(UIButton  *startImageObj, NSUInteger idx, BOOL * _Nonnull stop) {
        startImageObj.frame = CGRectMake((15*kAutoSizeScaleX+5) * idx , 0, 15*kAutoSizeScaleX, 15*kAutoSizeScaleX);
    }];
    [self addSubview:self.assessTextView];
    [self.assessTextView addSubview:self.placeholderLabel];
    [self addSubview:self.nextStepButton];
}

#pragma mark - Event
/// 下一步/提交评价
- (void)nextStepButtonAction {
    if (self.courseListDetaileArr.count == 1 || self.courseJudgeType == 1) {
        // ------ 情况1: 只有一个学员的时候 ------
        if (_score == 0) {
            [self makeToast:@"请对学员做出评分！"];
        }else {
            if (self.courseListDetaileArr.count == 1 ) {
                /// 我的课程--->学员详情--->课程评价
                // 1. 将对应的值添加到数组中
                LXCourseToStudentModel *model = [self.courseListDetaileArr firstObject];
                [self.courseRecordIdsArr addObject:[NSString stringWithFormat:@"%ld",model.courseRecordId]];
                [self.studentScoresArr addObject:[NSString stringWithFormat:@"%ld",_score*2]];
                if (self.assessTextView.text.length != 0 && self.assessTextView.text.length <= 500) {
                    [self.studentEvaluationContentsArr addObject:self.assessTextView.text];
                }else {
                    if (self.assessTextView.text.length > 500) {
                        [self makeToast:@"评价内容不能超过500字"];
                    }else if (self.assessTextView.text.length == 0){
                        [self.studentEvaluationContentsArr addObject:@""];
                    }
                }
                // 2. 提交评价
                if ([self.delegate respondsToSelector:@selector(lx_courseAssessSubmitCourseRecordIds:andStudentScores:andStudentEvaluationContents:)]) {
                    [self.delegate lx_courseAssessSubmitCourseRecordIds:self.courseRecordIdsArr andStudentScores:self.studentScoresArr andStudentEvaluationContents:self.studentEvaluationContentsArr];
                }
            }else if (self.courseJudgeType == 1) {
                // 我的--->课程记录---->课程评价
                if (self.assessTextView.text.length > 500) {
                    [self makeToast:@"评价内容不能超过500字"];
                }else {
                    if ([self.delegate respondsToSelector:@selector(lx_singleCourseRecordSubmitStudentScore:andStudentEvaluationContent:)]) {
                        [self.delegate lx_singleCourseRecordSubmitStudentScore:_score*2 andStudentEvaluationContent:self.assessTextView.text];
                    }
                }
            }
        }
    }else if (_recordCurrentIndex <= self.courseListDetaileArr.count) {
        // ------- 情况2：有多个学员的时候 -------
        if (_score == 0) {
            [self makeToast:@"请对学员做出评分！"];
        }else {
            // 确认按钮value
            if (_recordCurrentIndex+1 < self.courseListDetaileArr.count) {
                [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
            }else {
                // 提交评价
                [self.nextStepButton setTitle:@"提交评价" forState:UIControlStateNormal];
            }
            // 1. 存储已经评价的值
            LXCourseToStudentModel *model = self.courseListDetaileArr[_recordCurrentIndex-1];
            [self.courseRecordIdsArr addObject:[NSString stringWithFormat:@"%ld",model.courseRecordId]];
            [self.studentScoresArr addObject:[NSString stringWithFormat:@"%ld",_score*2]];
            if (self.assessTextView.text.length != 0) {
                [self.studentEvaluationContentsArr addObject:self.assessTextView.text];
            }else {
                [self.studentEvaluationContentsArr addObject:@""];
            }
            // 2.让界面的值刷新
            model = self.courseListDetaileArr[_recordCurrentIndex];
            self.nameLabel.text = model.studentName;
            [self startClearInitial];
            self.assessTextView.text = nil;
            self.placeholderLabel.text = @"请输入学员的课程评价";
            // 3. 累计+1
            _recordCurrentIndex += 1;
            
            // 4. 判断是否是最后一个学员
            if (_recordCurrentIndex == self.courseListDetaileArr.count) {
                if ([self.delegate respondsToSelector:@selector(lx_courseAssessSubmitCourseRecordIds:andStudentScores:andStudentEvaluationContents:)]) {
                    [self.delegate lx_courseAssessSubmitCourseRecordIds:self.courseRecordIdsArr andStudentScores:self.studentScoresArr andStudentEvaluationContents:self.studentEvaluationContentsArr];
                }
            }
        }
    }
}
/// 点击星星
- (void)startButtonAction:(UIButton *)startButton {
    // tag [10,14]
    _score = 0;
    for (NSInteger i = 10; i <= startButton.tag; i++) {
        UIButton *button = [self viewWithTag:i];
        [button setImage:[UIImage imageNamed:@"lx_cource_star_selected"] forState:UIControlStateNormal];
        _score += 1;
    }
    for (NSInteger j = startButton.tag+1; j < 15 ; j++) {
        UIButton *button = [self viewWithTag:j];
        [button setImage:[UIImage imageNamed:@"lx_cource_star_normal"] forState:UIControlStateNormal];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.placeholderLabel.text = @"";
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.placeholderLabel.text = @"请输入学员的课程评价";
    }
    return YES;
}
#pragma mark - privateMethod
/// 将评分清0
- (void)startClearInitial {
    _score = 0;
    for (NSInteger i = 10; i < 15; i++) {
        UIButton *button = [self viewWithTag:i];
        [button setImage:[UIImage imageNamed:@"lx_cource_star_normal"] forState:UIControlStateNormal];
    }
}
#pragma mark - setter
- (void)setCourseListDetaileArr:(NSArray<LXCourseToStudentModel *> *)courseListDetaileArr {
    _courseListDetaileArr = courseListDetaileArr;
    LXCourseToStudentModel *model = self.courseListDetaileArr[0];
    self.nameLabel.text = model.studentName;
    _recordCurrentIndex = 1;
    if (self.courseListDetaileArr.count == 1) {
        [self.nextStepButton setTitle:@"提交评价" forState:UIControlStateNormal];
    }else {
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
}
- (void)setTopSubjectModel:(LXCourseDetailModel *)topSubjectModel {
    _topSubjectModel = topSubjectModel;
    self.headView.courseListModel = self.topSubjectModel;
}

- (void)setCourseJudgeType:(NSInteger)courseJudgeType {
    _courseJudgeType = courseJudgeType;
    if (self.courseJudgeType == 1) {
        // 评价
        self.nextStepButton.hidden = NO;
        self.assessTextView.editable = YES;
        [self.nextStepButton setTitle:@"提交评价" forState:UIControlStateNormal];
        for (NSInteger i = 10; i < 15; i++) {
            UIButton *startBtn = [self viewWithTag:i];
            startBtn.enabled = YES;
            [startBtn setImage:[UIImage imageNamed:@"lx_cource_star_normal"] forState:UIControlStateNormal];
        }
    }else if (self.courseJudgeType == 2) {
        // 查看
        self.nextStepButton.hidden = YES;
        self.assessTextView.editable = NO;
        NSInteger scoreNumber = self.readCourseRecordModel.studentScore/2;
        for (NSInteger i = 10; i < 15; i++) {
            UIButton *startBtn = [self viewWithTag:i];
            startBtn.enabled = NO;
            if ((i-9) <= scoreNumber) {
                [startBtn setImage:[UIImage imageNamed:@"lx_cource_star_selected"] forState:UIControlStateNormal];
            }else {
                [startBtn setImage:[UIImage imageNamed:@"lx_cource_star_normal"] forState:UIControlStateNormal];
            }
        }
        self.assessTextView.text = self.readCourseRecordModel.studentEvaluationContent;
        self.placeholderLabel.text = nil;
    }
}

- (void)setReadCourseRecordModel:(LXSearchCourseRecordJudgeModel *)readCourseRecordModel {
    _readCourseRecordModel = readCourseRecordModel;
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
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}
- (UIView *)startFatherView {
    if (!_startFatherView) {
        _startFatherView = [[UIView alloc] init];
        for (NSInteger i = 0; i < 5; i++) {
            UIButton *startButton = [[UIButton alloc] init];
            [startButton setImage:[UIImage imageNamed:@"lx_cource_star_normal"] forState:UIControlStateNormal];
            startButton.tag = 10 + i;
            [startButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_startFatherView addSubview:startButton];
            [self.startArr addObject:startButton];
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
- (NSMutableArray *)courseRecordIdsArr {
    if (!_courseRecordIdsArr) {
        _courseRecordIdsArr = [[NSMutableArray alloc] init];
    }
    return _courseRecordIdsArr;
}
- (NSMutableArray *)studentScoresArr {
    if (!_studentScoresArr) {
        _studentScoresArr = [[NSMutableArray alloc] init];
    }
    return _studentScoresArr;
}
- (NSMutableArray *)studentEvaluationContentsArr {
    if (!_studentEvaluationContentsArr) {
        _studentEvaluationContentsArr = [[NSMutableArray alloc] init];
    }
    return _studentEvaluationContentsArr;
}
@end
