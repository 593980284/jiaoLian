//
//  LXMessageDetaileCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/22.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMessageDetaileCell.h"
#import "LXFindSingleCoachMsgModel.h"

@interface LXMessageDetaileCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation LXMessageDetaileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 15;
    CGFloat y = 20;
    CGFloat w = self.contentView.width - 30;
    CGFloat h = 18;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.titleLabel.frame) + 15;
    w = self.contentView.width - (15+26);
    h = 70;
    self.contentLabel.frame = CGRectMake(x, y, w, h);
    
    x = 15;
    y = CGRectGetMaxY(self.contentLabel.frame) + 23;
    w = self.contentView.width - 30;
    h = 12;
    self.timeLabel.frame = CGRectMake(x, y, w, h);
}

#pragma mark - setter
- (void)setModel:(LXFindSingleCoachMsgModel *)model {
    _model = model;
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content;
    self.timeLabel.text = self.model.date;
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel ;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}
@end
