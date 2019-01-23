//
//  LXStudentDetail_Cell.m
//  LXCoach
//
//  Created by slardar on 2019/1/23.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXStudentDetail_Cell.h"

@interface LXStudentDetail_Cell()
@property (nonatomic,strong) UILabel *subjuctNameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *statusImgView;
@end

@implementation LXStudentDetail_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 8.0;
        [self addSubview:bgView];
        [bgView addSubview:self.subjuctNameLabel];
        [bgView addSubview:self.contentLabel];
        _statusImgView = [UIImageView new];
        [bgView addSubview:_statusImgView];
        
        [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(8, 12, 0, 12));
        }];
        
        [_subjuctNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(8);
            make.right.equalTo(self.statusImgView.mas_left);
        }];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.subjuctNameLabel);
            make.bottom.mas_equalTo(-12);
        }];
        
        [_statusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(62, 20));
            make.right.mas_equalTo(8);
        }];
    }
    return self;
}

- (void)updateWithModel:(LXMyStudentDetailModel *)model andSubjectName:(NSString *)subName{
    NSString *subStr;
    switch ([subName integerValue]) {
        case 1:
            subStr = @"科目一";
            break;
        case 2:
            subStr = @"科目二";
            break;
        case 3:
            subStr = @"科目三";
            break;
        case 4:
            subStr = @"科目四";
            break;
        case 23:
            subStr = @"科目二 三";
            break;
        default:
            break;
    }
    _subjuctNameLabel.text = subStr;
    _contentLabel.text = [NSString stringWithFormat:@"%@ | %@",model.date,model.time];
}

- (UILabel *)subjuctNameLabel{
    if (!_subjuctNameLabel) {
        _subjuctNameLabel = [[UILabel alloc] init];
        _subjuctNameLabel.font = [UIFont systemFontOfSize:18];
        _subjuctNameLabel.textColor = TEXT_COLOR_BLACK;
    }
    return _subjuctNameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = TEXT_COLOR_GRAY;
    }
    return _contentLabel;
}

@end
