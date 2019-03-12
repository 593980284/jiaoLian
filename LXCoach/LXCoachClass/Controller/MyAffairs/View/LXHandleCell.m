//
//  LXHandleCell.m
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXHandleCell.h"
#import "LXUrlApi.h"

@interface LXHandleCell()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic,strong) UIImageView *sexImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *statusImgView;
@property (nonatomic,strong) UILabel *sujectClassLabel;
@property (nonatomic,strong) UIButton *missClassBtn;
@property (nonatomic,strong) UIButton *upClassBtn;
@end
#define btnTag 1314
@implementation LXHandleCell{
    LXAffairsHandleSSlist *_model;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *bgView = [UIView new];
        _bgView = bgView;
        bgView.layer.cornerRadius = 8;
        bgView.backgroundColor = [UIColor whiteColor];
        _iconImgView = [UIImageView new];
        _sexImgView = [UIImageView new];
        _statusImgView = [UIImageView new];

        [self addSubview:bgView];
        [bgView addSubview:_iconImgView];
        [_iconImgView addSubview:_sexImgView];
        [bgView addSubview:self.nameLabel];
        [bgView addSubview:_statusImgView];
        [bgView addSubview:self.sujectClassLabel];
        [bgView addSubview:self.missClassBtn];
        [bgView addSubview:self.upClassBtn];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.right.mas_equalTo(-14);
            make.top.bottom.equalTo(self);
        }];
        [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(11);
            make.height.width.mas_equalTo(65);
        }];
        [_sexImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self.iconImgView);
            make.height.width.mas_equalTo(28);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImgView.mas_right).offset(8);
            make.top.equalTo(self.iconImgView);
            make.right.equalTo(self.statusImgView.mas_left);
        }];
        [_statusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.top.equalTo(self.iconImgView);
            make.size.mas_equalTo(CGSizeMake(63, 22));
        }];
        [_sujectClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.right.equalTo(bgView);
            make.bottom.equalTo(self.iconImgView);
        }];
        
        [_missClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.upClassBtn.mas_left).offset(-12);
            make.size.mas_equalTo(CGSizeMake(78, 30));
            make.bottom.equalTo(self.upClassBtn);
        }];
        
        [_upClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(78, 30));
            make.bottom.mas_equalTo(-12);
            make.right.mas_equalTo(-12);
        }];
    }
    return self;
}

- (void)btnAction:(UIButton *)btn{
    if (_delegate && [_delegate respondsToSelector:@selector(cellActionWithModel:andType:)]) {
        [_delegate cellActionWithModel:_model andType:btn.tag - btnTag];
    }
}

- (void)updateWithModel:(LXAffairsHandleSSlist *)model andRowIndex:(NSInteger)rowIndex{
    if (rowIndex == 0) {
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
        }];
    }else{
        [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
        }];
    }
    _model = model;
    NSString *imageUrl = [kBaseImageUrl stringByAppendingPathComponent:model.studentPhoto];
    [_iconImgView lx_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_placeholder_image"]];
    
    UIImage *img = nil;
    if ([model.studentSex isEqualToString:@"男"]) {
        img = [UIImage imageNamed:@"lx_man"];
    }else if ([model.studentSex isEqualToString:@"女"]){
        img = [UIImage imageNamed:@"lx_woman"];
    }
    _sexImgView.image = img;
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.studentName];
    _sujectClassLabel.text = [NSString stringWithFormat:@"%@ | %@",model.subjectName,model.className];
    
    img = nil;
    if ([model.status isEqualToString:@"1"]) {
        img = [UIImage imageNamed:@"status_ywq"];
    }else if([model.status isEqualToString:@"4"]){
        img = [UIImage imageNamed:@"status_wqd"];
    }
    _statusImgView.image = img;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = TEXT_COLOR_BLACK;
        _nameLabel.font = TEXT_FONT(18);
    }
    return _nameLabel;
}

- (UILabel *)sujectClassLabel{
    if (!_sujectClassLabel) {
        _sujectClassLabel = [UILabel new];
        _sujectClassLabel.textColor = TEXT_COLOR_GRAY;
        _sujectClassLabel.font = TEXT_FONT(12);
    }
    return _sujectClassLabel;
}

- (UIButton *)missClassBtn{
    if (!_missClassBtn) {
        _missClassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _missClassBtn.tag = btnTag + 1;
        _missClassBtn.backgroundColor = BG_COLOR_RED;
        _missClassBtn.layer.cornerRadius = 4;
        _missClassBtn.clipsToBounds = YES;
        [_missClassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_missClassBtn setTitle:@"缺勤" forState:UIControlStateNormal];
        [_missClassBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _missClassBtn.titleLabel.font = TEXT_FONT(15);
    }
    return _missClassBtn;
}

- (UIButton *)upClassBtn{
    if (!_upClassBtn) {
        _upClassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _upClassBtn.tag = btnTag + 2;
        _upClassBtn.backgroundColor = BG_COLOR_BLUE;
        _upClassBtn.layer.cornerRadius = 4;
        _upClassBtn.clipsToBounds = YES;
        [_upClassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_upClassBtn setTitle:@"已到" forState:UIControlStateNormal];
        [_upClassBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _upClassBtn.titleLabel.font = TEXT_FONT(15);
    }
    return _upClassBtn;
}

@end
