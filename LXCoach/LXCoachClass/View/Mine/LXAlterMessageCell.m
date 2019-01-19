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
@property (nonatomic, strong) UILabel *titleName;
@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LXAlterMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleName];
        [self.contentView addSubview:self.rightArrow];
        [self.contentView addSubview:self.bottomView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 25;
    CGFloat y = 20;
    CGFloat w = self.width - (25+15+7);
    CGFloat h = 16;
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

#pragma mark - setter
- (void)setNameString:(NSString *)nameString {
    _nameString = nameString;
    self.titleName.text = _nameString;
}
#pragma mark - getter

- (UILabel *)titleName {
    if (!_titleName) {
        _titleName = [[UILabel alloc] init];
        _titleName.textColor = TEXT_COLOR_GRAY;
        _titleName.font = [UIFont systemFontOfSize:16];
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

@interface LXAlterMessageImageCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation LXAlterMessageImageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(16);
            make.size.mas_equalTo(CGSizeMake(73, 73));
        }];
        UILabel *tLabel = [UILabel new];
        tLabel.textColor = TEXT_COLOR_BLUE;
        tLabel.font = TEXT_FONT(14);
        tLabel.text = @"编辑头像";
        [self.contentView addSubview:tLabel];
        UIImage *tImg = [UIImage imageNamed:@"lx_acount_setting_change"];
        UIImageView *tImgView = [[UIImageView alloc] initWithImage:tImg];
        [self.contentView addSubview:tImgView];
        
        [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView.mas_bottom).offset(12);
            make.centerX.equalTo(self.contentView).offset(-tImg.size.width/2);
        }];
        
        [tImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tLabel.mas_right);
            make.size.mas_equalTo(tImg.size);
            make.centerY.equalTo(tLabel);
        }];
    }
    return self;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    NSString *imageUrl  = [kBaseImageUrl stringByAppendingPathComponent:self.imageName];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_header_placeholder"]];
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _iconImageView.layer.cornerRadius = 73.0/2;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _iconImageView.layer.borderWidth = 1;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}
@end
