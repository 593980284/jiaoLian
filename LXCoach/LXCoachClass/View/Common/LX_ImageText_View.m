//
//  LX_ImageText_View.m
//  LXCoach
//
//  Created by slardar on 2019/1/12.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LX_ImageText_View.h"

@implementation LX_ImageText_View
-(instancetype)initWithImage:(UIImage *)image placehold:(NSString *)placehold{
    if (self = [super init]) {
        _imgView = [UIImageView new];
        _imgView.image = image;
        [self addSubview:_imgView];
        
        _textField = [UITextField new];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = TEXT_FONT(15);
        _textField.textColor = TEXT_COLOR_BLACK;
        _textField.placeholder = placehold;
        [self addSubview:_textField];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = BG_COLOR_GRAY;
        [self addSubview:lineView];
        
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.left.equalTo(self);
            make.size.mas_equalTo(image.size);
        }];
        
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(16);
            make.centerY.right.equalTo(self);
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.bottom.equalTo(self);
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
