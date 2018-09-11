//
//  LXMessageListCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMessageListCell.h"

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
        [self valueToSubView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = 15;
    CGFloat w = 100 * kAutoSizeScaleX;
    CGFloat h = 80 * kAutoSizeScaleX;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 10;
    y = 20;
    w = self.contentView.width - (15 + 100*kAutoSizeScaleX + 10 + 24);
    h = 40;
    self.titleNameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconImageView.frame) + 10;
    y = CGRectGetMaxY(self.titleNameLabel.frame) + 12;
    w = self.contentView.width - (15 + 100*kAutoSizeScaleX + 10 + 24);
    h = 13;
    self.subjectTimeLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = self.contentView.height - .5;
    w = self.contentView.width;
    h = .5;
    self.bottomBreakLine.frame = CGRectMake(x, y, w, h);
}
- (void)valueToSubView {
    self.titleNameLabel.text = @"您在30分钟将有科目二课程，请及时到达训练场";
    self.subjectTimeLabel.text = @"科目一 8:00-10:00";
}
#pragma mark - getter
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
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
