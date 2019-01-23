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
            make.right.mas_equalTo(-8);
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
    UIImage *statusImg = nil;
    NSInteger status = [model.status integerValue];
    if (status == 2 || status == 6) {
        //已完成
        statusImg = [UIImage imageNamed:@"lx_detail_ywc"];
    }else if (status == 3 || status == 7){
        //缺勤
        statusImg = [UIImage imageNamed:@"lx_detail_queq"];
    }else if (status == 0){
        //已预约
        statusImg = [UIImage imageNamed:@"lx_detail_yiyuyue"];
    }else if (status == 1){
        //学员签到
        statusImg = [UIImage imageNamed:@"lx_detail_xyqd"];
    }else if (status == 4){
        //未签到
        statusImg = [UIImage imageNamed:@"lx_detail_wqd"];
    }else if (status == 5){
        //等待确认
        statusImg = [UIImage imageNamed:@"lx_detail_ddqr"];
    }else if (status == 10){
        //已取消
    }
    _subjuctNameLabel.text = subStr;
    _contentLabel.text = [NSString stringWithFormat:@"%@ | %@",model.date,model.time];
    _statusImgView.image = statusImg;
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
