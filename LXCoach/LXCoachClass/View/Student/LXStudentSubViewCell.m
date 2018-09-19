//
//  LXStudentSubViewCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/7.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentSubViewCell.h"
#import "LXMyStudentListModel.h"

@interface LXStudentSubViewCell ()
@property (nonatomic, strong) UIView *borderView;
/// 图片
@property (nonatomic, strong) UIImageView *iconImageView;
/// 姓名
@property (nonatomic, strong) UILabel *nameLabel;
/// 科目
@property (nonatomic, strong) UILabel *subjectNumber;
@property (nonatomic, strong) UILabel *iphoneNumber;
/// 拨打电话按钮
@property (nonatomic, strong) UIImageView *callMobile;
@end

@implementation LXStudentSubViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
        [self.contentView addSubview:self.borderView];
        [self.borderView addSubview:self.iconImageView];
        [self.borderView addSubview:self.nameLabel];
        [self.borderView addSubview:self.subjectNumber];
        [self.borderView addSubview:self.iphoneNumber];
        [self.borderView addSubview:self.callMobile];
//        [self valueToSubView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = 15;
    CGFloat w = self.width - 30;
    CGFloat h = self.height - 15;
    self.borderView.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = 15 * kAutoSizeScaleX;
    w = 80 * kAutoSizeScaleX;
    h = 64 * kAutoSizeScaleX;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 10;
    y = 26;
    w = 60;
    h = 15;
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.nameLabel.frame) + 10;
    y = 26;
    w = 50;
    h = 15;
    self.subjectNumber.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 10;
    y = CGRectGetMaxY(self.nameLabel.frame) + 14;
    w = 200;
    self.iphoneNumber.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetWidth(self.borderView.frame) - (15 + 33);
    y = 31*kAutoSizeScaleX;
    w = 33*kAutoSizeScaleX;
    h = 33*kAutoSizeScaleX;
    self.callMobile.frame = CGRectMake(x, y, w, h);
}
- (void)valueToSubView {
    self.nameLabel.text = @"张三";
    self.subjectNumber.text = @"科目二";
    self.iphoneNumber.text = @"17598785623";
}
#pragma mark - publicMethod
- (void)configStudentListModel:(LXMyStudentListModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.studentPhoto] placeholderImage:[UIImage imageNamed:@"lx_placeholder_image"]];
    self.nameLabel.text = model.studentName;
    self.subjectNumber.text = model.subjectName;
    self.iphoneNumber.text = model.mobile;
}
#pragma mark - Gesture
- (void)callMobileAction {
    self.callMobileBlock();
}

#pragma mark - getter
- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [[UIView alloc] init];
        _borderView.userInteractionEnabled = YES;
        _borderView.layer.borderWidth = 1;
        _borderView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _borderView.layer.cornerRadius = 5;
    }
    return _borderView;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"##333333"];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
- (UILabel *)subjectNumber {
    if (!_subjectNumber) {
        _subjectNumber = [[UILabel alloc] init];
        _subjectNumber.textAlignment = NSTextAlignmentCenter;
        _subjectNumber.textColor = [UIColor colorWithHexString:@"#666666"];
        _subjectNumber.font = [UIFont systemFontOfSize:12];
        _subjectNumber.layer.cornerRadius = 3;
        _subjectNumber.layer.borderColor = [UIColor colorWithHexString:@"#666666"].CGColor;
        _subjectNumber.layer.borderWidth = .5;
    }
    return _subjectNumber;
}
- (UILabel *)iphoneNumber {
    if (!_iphoneNumber) {
        _iphoneNumber = [[UILabel alloc] init];
        _iphoneNumber.font = [UIFont systemFontOfSize:16];
        _iphoneNumber.textColor = [UIColor colorWithHexString:@"#666666"];
        _iphoneNumber.textAlignment = NSTextAlignmentLeft;
    }
    return _iphoneNumber;
}
- (UIImageView *)callMobile {
    if (!_callMobile) {
        _callMobile = [[UIImageView alloc] init];
        _callMobile.userInteractionEnabled = YES;
        _callMobile.image = [UIImage imageNamed:@"lx_student_callmobile"];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callMobileAction)];
        [_callMobile addGestureRecognizer:tapGesture];
    }
    return _callMobile;
}


@end
