//
//  LXMessageListCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMessageListCell.h"
#import "LXFindCoachMsgModel.h"

@interface LXMessageListCell()
@property (nonatomic, strong) UIImageView *iconImageView;
/// 标题
@property (nonatomic, strong) UILabel *titleNameLabel;
/// 科目时间
@property (nonatomic, strong) UILabel *subjectTimeLabel;

@property (nonatomic, strong) UIView *bottomBreakLine;
@end

@implementation LXMessageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleNameLabel];
        [self.contentView addSubview:self.subjectTimeLabel];
        [self.contentView addSubview:self.bottomBreakLine];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = 23;
    CGFloat w = 66;
    CGFloat h = 66;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 16;
    y = 28;
    w = self.contentView.width - (15 + 66 + 16 + 40);
    h = 32;
    self.titleNameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 16;
    y = CGRectGetMaxY(self.titleNameLabel.frame) + 11;
    w = self.contentView.width - (15 + 66 + 16 + 40);
    h = 13;
    self.subjectTimeLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = self.contentView.height - .5;
    w = self.contentView.width;
    h = .5;
    self.bottomBreakLine.frame = CGRectMake(x, y, w, h);
}

#pragma mark - publicMethod
- (void)configMessagListValue:(LXFindCoachMsgModel *)model {
    self.titleNameLabel.text = model.content;
    self.subjectTimeLabel.text = model.date;
}

#pragma mark - getter
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _iconImageView.image = [UIImage imageNamed:@"lx_new_message"];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}
- (UILabel *)titleNameLabel {
    if (!_titleNameLabel) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.font = [UIFont systemFontOfSize:16];
        _titleNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleNameLabel.textAlignment = NSTextAlignmentLeft;
        _titleNameLabel.numberOfLines = 0;
    }
    return _titleNameLabel;
}
- (UILabel *)subjectTimeLabel {
    if (!_subjectTimeLabel) {
        _subjectTimeLabel = [[UILabel alloc] init];
        _subjectTimeLabel.textAlignment = NSTextAlignmentLeft;
        _subjectTimeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _subjectTimeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _subjectTimeLabel;
}
- (UIView *)bottomBreakLine {
    if (!_bottomBreakLine) {
        _bottomBreakLine = [[UIView alloc] init];
        _bottomBreakLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _bottomBreakLine;
}
@end
