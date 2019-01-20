//
//  LXStudentSubViewCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/7.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentSubViewCell.h"
#import "LXMyStudentListModel.h"
#import "LXUrlApi.h"

@interface LXStudentSubViewCell ()
@property (nonatomic, strong) UIView *borderView;
/// 图片
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *sexImgView;
/// 姓名
@property (nonatomic, strong) UILabel *nameLabel;
/// 科目
@property (nonatomic, strong) UILabel *subjectNumber;
@property (nonatomic, strong) UILabel *iphoneNumber;
/// 拨打电话按钮
@property (nonatomic, strong) UIButton *callMobile;
@end

@implementation LXStudentSubViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.borderView];
        [_borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(8, 12, 0, 12));
        }];
        
        [_borderView addSubview:self.iconImageView];
        [_iconImageView addSubview:self.sexImgView];
        [_borderView addSubview:self.nameLabel];
        [_borderView addSubview:self.iphoneNumber];
        [_borderView addSubview:self.subjectNumber];
        [_borderView addSubview:self.callMobile];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(65);
        }];
        [_sexImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.iconImageView);
            make.width.height.mas_equalTo(25);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView);
            make.left.equalTo(self.iconImageView.mas_right).offset(8);
            make.right.mas_equalTo(0);
        }];
        [_iphoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.nameLabel);
            make.bottom.equalTo(self.subjectNumber.mas_top).offset(-4);
        }];
        [_subjectNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.nameLabel);
            make.bottom.equalTo(self.iconImageView);
        }];
        [_callMobile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(80, 33));
            make.right.mas_equalTo(-8);
        }];
    }
    return self;
}

#pragma mark - publicMethod
- (void)configStudentListModel:(LXMyStudentListModel *)model {
    UIImage *img = nil;
    if ([model.sex isEqualToString:@"男"]) {
        img = [UIImage imageNamed:@"lx_man"];
    }else if ([model.sex isEqualToString:@"女"]){
        img = [UIImage imageNamed:@"lx_woman"];
    }
    _sexImgView.image = img;
    NSString *imageUrl = [kBaseImageUrl stringByAppendingPathComponent:model.studentPhoto];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_placeholder_image"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ · %@",model.studentName,model.subjectName];
    self.subjectNumber.text = [NSString stringWithFormat:@"%@ | 完成学时%@/%@",model.className,model.useCount,model.allCount];
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
        _borderView.layer.cornerRadius = 8;
        _borderView.backgroundColor = [UIColor whiteColor];
    }
    return _borderView;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UIImageView *)sexImgView{
    if (!_sexImgView) {
        _sexImgView = [[UIImageView alloc] init];
    }
    return _sexImgView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = TEXT_COLOR_BLACK;
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
- (UILabel *)subjectNumber {
    if (!_subjectNumber) {
        _subjectNumber = [[UILabel alloc] init];
        _subjectNumber.textColor = TEXT_COLOR_GRAY;
        _subjectNumber.font = [UIFont systemFontOfSize:12];
    }
    return _subjectNumber;
}
- (UILabel *)iphoneNumber {
    if (!_iphoneNumber) {
        _iphoneNumber = [[UILabel alloc] init];
        _iphoneNumber.font = [UIFont systemFontOfSize:12];
        _iphoneNumber.textColor = TEXT_COLOR_GRAY;
        _iphoneNumber.textAlignment = NSTextAlignmentLeft;
    }
    return _iphoneNumber;
}
- (UIButton *)callMobile {
    if (!_callMobile) {
        _callMobile = [UIButton buttonWithType:UIButtonTypeCustom];
        _callMobile.backgroundColor = BG_COLOR_BLUE;
        _callMobile.layer.cornerRadius = 4.0;
        [_callMobile setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_callMobile setTitle:@"一键呼叫" forState:UIControlStateNormal];
        _callMobile.titleLabel.font = TEXT_FONT(15);
        [_callMobile addTarget:self action:@selector(callMobileAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callMobile;
}


@end
