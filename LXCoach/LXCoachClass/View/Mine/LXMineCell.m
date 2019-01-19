//
//  LXMineCell.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMineCell.h"

@interface LXMineCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *rightArrow;
/// 分割线
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation LXMineCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.rightArrow];
        [self.contentView addSubview: self.bottomLine];
        [self.contentView addSubview:self.rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-44);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 25;
    CGFloat y = 17;
    CGFloat w = 18;
    CGFloat h = 18;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
    self.iconImageView.centerY = self.contentView.centerY;
    
    x = CGRectGetMaxX(self.iconImageView.frame)+13;
    y = 18;
    w = self.width - (55+15+10);
    h = 14;
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    self.nameLabel.centerY = self.contentView.centerY;
    
    x = self.width - (7+15);
    y = 20;
    w = 7;
    h = 11;
    self.rightArrow.frame = CGRectMake(x, y, w, h);
    self.rightArrow.centerY = self.contentView.centerY;
    
    x = 25;
    y = self.height-.5;
    w = self.width - 25 - 18;
    h = .5;
    self.bottomLine.frame = CGRectMake(x, y, w, h);
}

- (void)mineCellValuation:(NSDictionary *)value {
    if ([[value objectForKey:@"clickType"]integerValue] == 4 ) {
        _rightLabel.text = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    }else{
        _rightLabel.text = @"";
    }
    _iconImageView.image = [UIImage imageNamed:[value objectForKey:@"imageName"]];
    _nameLabel.text = [value objectForKey:@"textName"];
}

#pragma mark - getter
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.textColor = TEXT_COLOR_BLACK;
        _rightLabel.font = TEXT_FONT(15);
    }
    return _rightLabel;
}
- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] init];
        _rightArrow.image = [UIImage imageNamed:@"lx_mine_message_arrowright"];
    }
    return _rightArrow;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _bottomLine;
}
@end
