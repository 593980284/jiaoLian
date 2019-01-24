//
//  LXStudentDetaileHeaderView.m
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentDetaileHeaderView.h"
#import "LXMyStudentListModel.h"
#import "LXUrlApi.h"
@interface LXStudentDetaileHeaderView()
@property (nonatomic, strong) UIImageView *iconImageView;
/// 姓名
@property (nonatomic, strong) UILabel *nameLabel;
/// 手机号
@property (nonatomic, strong) UILabel *phoneNumber;
@property (nonatomic, strong) UILabel *subjectLabel;
/// 分割线
@property (nonatomic, strong) UIView *bottomBreakLine;

@end

@implementation LXStudentDetaileHeaderView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneNumber];
        [self addSubview:self.subjectLabel];
        [self addSubview:self.bottomBreakLine];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = 15;
    CGFloat w = 80;
    CGFloat h = 80;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 10;
    y = CGRectGetMinY(self.iconImageView.frame) + 5;
    w = self.width - (100 * kAutoSizeScaleX +15+10+15);
    h = 16;
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 12;
    y = CGRectGetMaxY(self.nameLabel.frame) + 16;
    w = self.width - (100 * kAutoSizeScaleX +15+12+15);
    h = 12;
    self.phoneNumber.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 12;
    y = CGRectGetMaxY(self.phoneNumber.frame) + 8;
    w = self.width - (100 * kAutoSizeScaleX +15+12+15);
    h = 12;
    self.subjectLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = self.height - .5;
    w = self.width;
    h = .5;
    self.bottomBreakLine.frame = CGRectMake(x, y, w, h);
}

#pragma mark - publicMethod
- (void)configValue:(LXMyStudentListModel *)model {
    NSString *imageUrl = [kBaseImageUrl stringByAppendingPathComponent:model.studentPhoto];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_placeholder_image"]];
    self.nameLabel.text = model.studentName;
    self.phoneNumber.text = model.mobile;
    if (!!model.useCount && !! model.allCount) {
        self.subjectLabel.text = [NSString stringWithFormat:@"%@ | 完成学时%@/%@",model.subjectName,model.useCount,model.allCount];
    }else{
        self.subjectLabel.text = [NSString stringWithFormat:@"%@",model.subjectName];
    }
}

#pragma mark - getter
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
- (UILabel *)phoneNumber {
    if (!_phoneNumber) {
        _phoneNumber = [[UILabel alloc] init];
        _phoneNumber.textColor = TEXT_COLOR_YELLOW;
        _phoneNumber.textAlignment = NSTextAlignmentLeft;
        _phoneNumber.font = [UIFont systemFontOfSize:12];
    }
    return _phoneNumber;
}

- (UILabel *)subjectLabel {
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.textColor = TEXT_COLOR_GRAY;
        _subjectLabel.textAlignment = NSTextAlignmentLeft;
        _subjectLabel.font = [UIFont systemFontOfSize:12];
    }
    return _subjectLabel;
}

- (UIView *)bottomBreakLine {
    if (!_bottomBreakLine) {
        _bottomBreakLine = [[UIView alloc] init];
        _bottomBreakLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _bottomBreakLine;
}

@end
