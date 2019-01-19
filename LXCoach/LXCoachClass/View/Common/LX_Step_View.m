//
//  LX_Step_View.m
//  LXCoach
//
//  Created by slardar on 2019/1/15.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LX_Step_View.h"

@implementation LX_Step_View
- (instancetype)init{
    if (self = [super init]) {
        _stepOneImgView = [UIImageView new];
        [self addSubview:_stepOneImgView];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = BG_COLOR_BLUE;
        [self addSubview:lineView];
        
        _stepTwoImgView = [UIImageView new];
        [self addSubview:_stepTwoImgView];
        
        _explainLabel = [[UILabel alloc] init];
        _explainLabel.textColor = TEXT_COLOR_BLACK;
        _explainLabel.font = TEXT_FONT(16);
        [self addSubview:_explainLabel];
        
        [_stepOneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lineView);
            make.right.equalTo(lineView.mas_left).offset(-8);
        }];

        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(28);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kAutoSizeScaleX*62, 1));
        }];
        
        [_stepTwoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lineView);
            make.left.equalTo(lineView.mas_right).offset(8);
        }];
        
        [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(lineView.mas_bottom).offset(27);
        }];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
