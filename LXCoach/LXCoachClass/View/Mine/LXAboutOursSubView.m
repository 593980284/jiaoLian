//
//  LXAboutOursSubView.m
//  LXCoach
//
//  Created by GDD on 2018/9/18.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXAboutOursSubView.h"

@interface LXAboutOursSubView ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation LXAboutOursSubView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.textView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = self.width/2 - 87*kAutoSizeScaleX/2;
    CGFloat y = 41;
    CGFloat w = 87*kAutoSizeScaleX;
    CGFloat h = 85*kAutoSizeScaleX;
    self.iconImageView.frame = CGRectMake(x, y, w, h);
    
    x = 20;
    y = CGRectGetMaxY(self.iconImageView.frame) + 25;
    w = self.width - 40;
    h = 20;
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    x = 30;
    y = CGRectGetMaxY(self.nameLabel.frame) + 40;
    w = self.width - 60;
    h = 300;
    self.textView.frame = CGRectMake(x, y, w, h);
}
#pragma mark - getter
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"lx_mine_logo"];
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"乐享学驾·教练版APP";
    }
    return _nameLabel;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor colorWithHexString:@"#000000"];
        _textView.editable = NO;
        NSString *labelText = @"    乐享学驾app是中寰卫星导航通信有限公司联合运管、南京各大驾校联合打造南京驾培行业服务品牌，进一步促进市场的公平公正、管理服务高效便捷，满足人民群众对培训质量、学驾体验度日益增强的美好学驾需求。\n    本App运行过程中，可能产生移动通信费用，费用由通信运营商收取。";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];//调整行间距
        paragraphStyle.alignment = NSTextAlignmentLeft;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        _textView.attributedText = attributedString;
        _textView.font = [UIFont systemFontOfSize:14];
        [_textView sizeToFit];
    }
    return _textView;
}
@end
