//
//  LXAlterMessageCell.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXAlterMessageCell.h"
#import "LXUrlApi.h"

@interface LXAlterMessageCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleName;
@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LXAlterMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleName];
        [self.contentView addSubview:self.rightArrow];
        [self.contentView addSubview:self.bottomView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 25;
    CGFloat y = 8;
    CGFloat w = 40*kAutoSizeScaleX;
    CGFloat h = 40*kAutoSizeScaleX;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
    self.iconImageView.centerY = self.contentView.centerY;
    
    x = 25;
    y = 20;
    w = self.width - (25+15+7);
    h = 16;
    self.titleName.frame = CGRectMake(x, y, w, h);
    self.titleName.centerY = self.contentView.centerY;
    
    x = self.width - (15+7);
    y = 22;
    w = 7;
    h = 11;
    self.rightArrow.frame = CGRectMake(x, y, w, h);
    self.rightArrow.centerY = self.contentView.centerY;
    
    x = 15;
    y = self.height - .5;
    w = self.width - 15;
    h = .5;
    self.bottomView.frame = CGRectMake(x, y, w, h);
}
#pragma mark - publicMethod
- (void)hiddenCurrenViewType:(NSInteger)type {
    if (type == 1) {
        self.titleName.hidden = YES;
    }else if (type == 2) {
        self.iconImageView.hidden = YES;
    }
}

#pragma mark - setter
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    NSString *imageUrl  = [kBaseImageUrl stringByAppendingPathComponent:self.imageName];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_header_placeholder"]];
}

- (void)setNameString:(NSString *)nameString {
    _nameString = nameString;
    self.titleName.text = _nameString;
}
#pragma mark - getter
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _iconImageView.layer.cornerRadius = 40*kAutoSizeScaleX/2;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _iconImageView.layer.borderWidth = 1;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}
- (UILabel *)titleName {
    if (!_titleName) {
        _titleName = [[UILabel alloc] init];
        _titleName.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleName.font = [UIFont systemFontOfSize:17];
        _titleName.textAlignment = NSTextAlignmentLeft;
    }
    return _titleName;
}
- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] init];
        _rightArrow.image = [UIImage imageNamed:@"lx_mine_message_arrowright"];
    }
    return _rightArrow;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _bottomView;
}
@end
