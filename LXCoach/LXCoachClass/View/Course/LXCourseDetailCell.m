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
#import "LXNavigationManager.h"

@interface LXCourseDetailCell()

@property (nonatomic, strong) FLAnimatedImageView *leftImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *subjectNameLabel;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic,strong) UIImageView *statusImgView;

@end


@implementation LXCourseDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 8.0;
    
    _statusImgView = [UIImageView new];
    
    [self addSubview:bgView];
    [bgView addSubview:self.leftImageView];
    [bgView addSubview:self.nameLabel];
    [bgView addSubview:self.subjectNameLabel];
    [bgView addSubview:self.button1];
    [bgView addSubview:self.button2];
    [bgView addSubview:_statusImgView];
    
    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 12, 0, 12));
    }];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(8);
        make.size.mas_equalTo(56);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImageView);
        make.left.equalTo(self.leftImageView.mas_right).offset(8);
        make.right.equalTo(self.statusImgView.mas_left);
    }];
    
    [_subjectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.bottom.equalTo(self.leftImageView);
    }];
    
    [_statusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImageView);
        make.size.mas_equalTo(CGSizeMake(62, 20));
        make.right.mas_equalTo(-8);
    }];
    
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.bottom.mas_equalTo(-12);
    }];
    
    [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.button1.mas_left).offset(-12);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.bottom.mas_equalTo(-12);
    }];
}

#pragma mark - Event
- (void)button1Action:(UIButton *)button {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_courseStudentModel.mobile];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)button2Action:(UIButton *)button {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"学员考勤" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *missAction = [UIAlertAction actionWithTitle:@"缺勤" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.studentOperationBtn1Block();
    }];
    UIAlertAction *upAction = [UIAlertAction actionWithTitle:@"已到" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.studentOperationBtn2Block();
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:missAction];
    [alertController addAction:upAction];
    UIViewController *vc = [LXNavigationManager lx_currentController];
    [vc presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - setter
- (void)setCourseStudentModel:(LXCourseToStudentModel *)courseStudentModel {
    _courseStudentModel = courseStudentModel;
    NSString *imageUrl = [kBaseImageUrl stringByAppendingPathComponent:self.courseStudentModel.studentPhoto];
    [self.leftImageView lx_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_placeholder_image"]];
    self.nameLabel.text = self.courseStudentModel.studentName;
    self.subjectNameLabel.text = self.courseStudentModel.className;
    
    UIImage *statusImg = nil;
    NSInteger status = courseStudentModel.status;
    _button2.hidden = YES;
    if (status == 2 || status == 6) {
        //已完成
        statusImg = [UIImage imageNamed:@"lx_detail_ywc"];
    }else if (status == 3 || status == 7){
        //缺勤
        statusImg = [UIImage imageNamed:@"lx_detail_queq"];
    }else if (status == 0){
        //已预约
        statusImg = [UIImage imageNamed:@"lx_detail_yiyuyue"];
    }else if (status == 1){
        //学员签到
        _button2.hidden = NO;
        statusImg = [UIImage imageNamed:@"lx_detail_xyqd"];
    }else if (status == 4){
        //学员未签到
        _button2.hidden = NO;
        statusImg = [UIImage imageNamed:@"lx_detail_wqd"];
    }else if (status == 5){
        //等待确认
        statusImg = [UIImage imageNamed:@"lx_detail_ddqr"];
    }else if (status == 10){
        //已取消
    }
    _statusImgView.image = statusImg;
}

#pragma mark - getter
- (FLAnimatedImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[FLAnimatedImageView alloc]init];
        _leftImageView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
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

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [[UIButton alloc] init];
        _button1.backgroundColor = BG_COLOR_BLUE;
        [_button1 setTitle:@"一键呼叫" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button1.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
        _button1.layer.cornerRadius = 5;
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [[UIButton alloc] init];
        _button2.backgroundColor = BG_COLOR_BLUE;
        [_button2 setTitle:@"学员考勤" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button2.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
        _button2.layer.cornerRadius = 5;
    }
    return _button2;
}

@end
