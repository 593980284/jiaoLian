//
//  LXIntroMineSubView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXIntroMineSubView.h"
#import "LXMineModel.h"
#import "LXUrlApi.h"

@interface LXIntroMineSubView ()
@property (nonatomic, strong) UIView *identityView;
@property (nonatomic, strong) UIView *starView;
@property (nonatomic, strong) UIView *coachLabelView;
@property (nonatomic, strong) LXMineModel *mineModel;
@end

@implementation LXIntroMineSubView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(102);
        }];
        //头像
        UIImageView *headerImageView = [UIImageView new];
        [headerView addSubview:headerImageView];
        NSString *imageUrl = [kBaseImageUrl stringByAppendingPathComponent:self.mineModel.photo];
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"lx_header_placeholder"]];
        //名称
        UILabel *nameLabel = [UILabel new];
        nameLabel.text = _mineModel.coachName;
        nameLabel.textColor = TEXT_COLOR_BLACK;
        nameLabel.font = TEXT_FONT(18);
        [headerView addSubview:nameLabel];
        //星星
        [headerView addSubview:self.starView];
        //标签
        [headerView addSubview:self.identityView];
        //教龄
        UILabel *teachTypeLabel = [UILabel new];
        teachTypeLabel.text = [NSString stringWithFormat:@"%@年教龄 · %@",_mineModel.teachAge,_mineModel.teachType];
        teachTypeLabel.textColor = TEXT_COLOR_GRAY;
        teachTypeLabel.font = TEXT_FONT(15);
        [headerView addSubview:teachTypeLabel];
        
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(20);
            make.centerY.equalTo(headerView);
            make.size.mas_equalTo(CGSizeMake(63, 63));
        }];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerImageView.mas_right).offset(13);
            make.top.equalTo(headerImageView);
        }];
        [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right);
            make.right.equalTo(headerView);
            make.centerY.equalTo(nameLabel);
        }];
        [_identityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel);
            make.right.equalTo(headerView);
            make.top.equalTo(nameLabel.mas_bottom);
            make.bottom.equalTo(teachTypeLabel.mas_top);
        }];
        [teachTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel);
            make.bottom.equalTo(headerImageView);
        }];
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.mas_bottom).offset(7);
            make.left.equalTo(self).offset(13);
            make.right.equalTo(self).offset(-13);
        }];
        
        UILabel *carLabel = [UILabel new];
        carLabel.textColor = TEXT_COLOR_GRAY;
        carLabel.font = TEXT_FONT(16);
        carLabel.text = @"绑定车辆 :";
        [bottomView addSubview:carLabel];
        [carLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView).offset(14);
            make.top.equalTo(bottomView).offset(20);
        }];
        
        UILabel *carValueLabel = [UILabel new];
        carValueLabel.text = _mineModel.carNo;
        carValueLabel.textColor = TEXT_COLOR_BLACK;
        carValueLabel.font = TEXT_FONT(16);
        [bottomView addSubview:carValueLabel];
        [carValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(carLabel.mas_right).offset(8);
            make.centerY.equalTo(carLabel);
        }];
        
        UILabel *caochLabel = [UILabel new];
        caochLabel.textColor = TEXT_COLOR_GRAY;
        caochLabel.font = TEXT_FONT(16);
        caochLabel.text = @"教练标签 :";
        [bottomView addSubview:caochLabel];
        [caochLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(carLabel);
            make.top.equalTo(carLabel.mas_bottom).offset(20);
        }];
        
        [bottomView addSubview:self.coachLabelView];
        [_coachLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(carLabel.mas_right).offset(8);
            make.centerY.equalTo(caochLabel);
            make.right.equalTo(bottomView);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *presentLabel = [UILabel new];
        presentLabel.textColor = TEXT_COLOR_GRAY;
        presentLabel.font = TEXT_FONT(16);
        presentLabel.text = @"教练简介 :";
        [bottomView addSubview:presentLabel];
        [presentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(carLabel);
            make.width.mas_equalTo([presentLabel sizeThatFits:CGSizeZero].width);
            make.top.equalTo(caochLabel.mas_bottom).offset(20);
        }];
        
        UILabel *presentValueLabel = [UILabel new];
        presentValueLabel.text = [NSString stringWithFormat:@"%@",_mineModel.present];
        presentValueLabel.textColor = TEXT_COLOR_BLACK;
        presentValueLabel.font = TEXT_FONT(16);
        presentValueLabel.numberOfLines = 0;
        [bottomView addSubview:presentValueLabel];
        [presentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(presentLabel);
            make.left.equalTo(presentLabel.mas_right).offset(8);
            make.right.equalTo(bottomView);
        }];
        
        CGFloat pHeight = [presentValueLabel sizeThatFits:CGSizeMake(245*kAutoSizeScaleX, 0)].height;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(pHeight + 86 + 72);
        }];
    }
    return self;
}

#pragma mark - getter
- (UIView *)identityView{
    if (!_identityView) {
        _identityView = [[UIView alloc] init];
        
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.showsHorizontalScrollIndicator = false;
        [_identityView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_identityView);
        }];
        
        NSArray *array = [_mineModel.identity componentsSeparatedByString:@","];
        CGFloat x=0;
        for (NSString *tempStr in array) {
            UIImage *img = nil;
            if ([tempStr isEqualToString:@"131000"]) {//金牌
                img = [UIImage imageNamed:@"lx_jiaoljp"];
            }else if ([tempStr isEqualToString:@"132000"]){//党员
                img = [UIImage imageNamed:@"lx_jiaoldy"];
            }
            UIImageView *imgView = [UIImageView new];
            imgView.image = img;
            [scrollView addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).offset(x);
                make.size.mas_equalTo(img.size);
                make.centerY.equalTo(scrollView);
            }];
            x = x + (img?img.size.width :0) + 8;
        }
        scrollView.contentSize = CGSizeMake(x, 20);
    }
    return _identityView;
}

-(UIView *)starView{
    if (!_starView) {
        _starView = [UIView new];
        CGFloat x = 16;
        CGFloat star = [_mineModel.coachStar integerValue]/2.0;
        for (int i = 5; i > 0; i--) {
            UIImage *img = nil;
            if (i <= star) {
                img = [UIImage imageNamed:@"lx_acount_star_up"];
            }else if(i > star && i <= star + 0.5){
                img = [UIImage imageNamed:@"lx_acount_star_half"];
            }else{
                img = [UIImage imageNamed:@"lx_acount_star_down"];
            }
            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
            [_starView addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self->_starView).offset(-x);
                make.size.mas_equalTo(img.size);
                make.centerY.equalTo(self->_starView);
            }];
            x = x + img.size.width + 4;
        }
    }
    return _starView;
}

- (UIView *)coachLabelView{
    if (!_coachLabelView) {
        _coachLabelView = [[UIView alloc] init];
        
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.showsHorizontalScrollIndicator = false;
        [_coachLabelView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_coachLabelView);
        }];
        
        NSArray *array = [_mineModel.coachLabel componentsSeparatedByString:@","];
        CGFloat x=0;
        for (NSString *tempStr in array) {
            UILabel *label = [UILabel new];
            label.textColor = TEXT_COLOR_YELLOW;
            label.font = TEXT_FONT(11);
            label.layer.cornerRadius = 4;
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.borderColor = TEXT_COLOR_YELLOW.CGColor;
            label.layer.borderWidth = 1;
            label.text = tempStr;
            [scrollView addSubview:label];
            CGFloat width = [label sizeThatFits:CGSizeZero].width + 12;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(scrollView).offset(x);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(18);
                make.centerY.equalTo(scrollView);
            }];
            x = x + width + 8;
        }
        scrollView.contentSize = CGSizeMake(x, 20);
    }
    return _coachLabelView;
}

- (LXMineModel *)mineModel {
    if (!_mineModel) {
        _mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    }
    return _mineModel;
}
@end
