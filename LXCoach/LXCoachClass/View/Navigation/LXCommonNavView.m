//
//  LXCommonNavView.m
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCommonNavView.h"
/** 左右按钮最小宽度 */
static CGFloat const kLXNavigationButtonWidth = 44;
/** 水平间距 */
static CGFloat const kHorizontalMargin = 13;
//static CGFloat const kFontSize = 15;
static CGFloat const kShadowOpacity = 0.4;

@interface LXCommonNavView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIImageView *leftButtonImageView;
//@property (nonatomic, strong) UILabel *leftButtonTitleLabel;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIImageView *rightButtonImageView;
@property (nonatomic, strong) UILabel *rightButtonTitleLabel;

@property (nonatomic, strong) UIView *seprateLine;
@property (nonatomic, strong) UIBezierPath *shadowPath;

@end

@implementation LXCommonNavView
- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenSize.width, LXNavigationViewHeight+CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]));
        self.backgroundColor = [UIColor whiteColor];
        UIView *bottomView = [[UIView alloc] init];
        bottomView.frame = CGRectMake(0, self.height-.5, self.width, .5);
        bottomView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:bottomView];
        //  阴影
//        _shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
//        self.layer.masksToBounds = NO;
//        self.layer.shadowColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);
//        self.layer.shadowOpacity = kShadowOpacity;
//        self.layer.shadowPath = _shadowPath.CGPath;
        
        // 添加左侧按钮
        [self addSubview:self.leftButton];
        CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
        self.leftButton.frame = CGRectMake(0, statusBarHeight, kLXNavigationButtonWidth, kLXNavigationButtonWidth);
        
        // 添加右侧按钮
//        [self addSubview:self.rightButton];
//        self.rightButton.frame = CGRectMake(self.width-(kLXNavigationButtonWidth+10), statusBarHeight, kLXNavigationButtonWidth, kLXNavigationButtonWidth);
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [self init]) {
        [self updateNavigationTitle:title];
    }
    return self;
}

- (void)hiddenSeprateLine {
    self.layer.shadowOpacity = 0.0;
}

- (void)showSeprateLine {
    self.layer.shadowOpacity = kShadowOpacity;
}


- (void)changeTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}

- (void)setShowBackButton:(BOOL)showBackButton {
    _showBackButton = showBackButton;
    if (showBackButton) {
        self.leftButton.hidden = NO;
//        self.leftButtonTitleLabel.hidden = YES;
        self.leftButtonImageView.image = [UIImage imageNamed:@"xhs_backbutton"];
    }
}


- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    _leftButtonTitle = leftButtonTitle;
    self.leftButton.hidden = NO;
    self.leftButtonImageView.hidden = YES;
//    self.leftButtonTitleLabel.text = leftButtonTitle;
}

- (void)setLeftButtonTitleColor:(UIColor *)leftButtonTitleColor {
    _leftButtonTitleColor = leftButtonTitleColor;
//    self.leftButtonTitleLabel.textColor = leftButtonTitleColor;
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    _rightButtonTitle = rightButtonTitle;
    self.rightButtonImageView.hidden = YES;
    self.rightButton.hidden = NO;
    self.rightButtonTitleLabel.text = rightButtonTitle;
}

- (void)setRightButtonTitleColor:(UIColor *)rightButtonTitleColor {
    _rightButtonTitleColor = rightButtonTitleColor;
    self.rightButtonTitleLabel.textColor = rightButtonTitleColor;
}

- (void)setLeftButtonImage:(UIImage *)leftButtonImage {
    _leftButtonImage = leftButtonImage;
//    self.leftButtonTitleLabel.hidden = YES;
    self.leftButton.hidden = NO;
    self.leftButtonImageView.image = leftButtonImage;
}

- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    _rightButtonImage = rightButtonImage;
    self.rightButtonTitleLabel.hidden = YES;
    self.rightButton.hidden = NO;
    self.rightButtonImageView.image = rightButtonImage;
}

- (void)updateNavigationTitle:(NSString *)title {
    self.titleLabel.text = title;
    if (!self.titleLabel.superview) {
        [self addSubview:self.titleLabel];
        CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame), statusBarHeight, self.width-(CGRectGetWidth(self.leftButton.frame)+CGRectGetWidth(self.rightButton.frame)+30), LXNavigationViewHeight);
        
    }
}

#pragma mark - PrivateMethod

- (void)clickLeftButton {
    if ([self.delegate respondsToSelector:@selector(lx_clickLeftButton)]) {
        [self.delegate lx_clickLeftButton];
    }
}

- (void)clickRightButton {
    if ([self.delegate respondsToSelector:@selector(lx_clickRightButton)]) {
        [self.delegate lx_clickRightButton];
    }
}

#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.hidden = YES;
        [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        _leftButtonImageView = [[UIImageView alloc] init];
        [_leftButton addSubview:_leftButtonImageView];
        _leftButtonImageView.frame = CGRectMake(CGRectGetMinX(_leftButton.frame)+kHorizontalMargin, CGRectGetMinY(self.leftButton.frame)+13, 10, 18);
        
//        _leftButtonTitleLabel = [[UILabel alloc] init];
//        _leftButtonTitleLabel.font = [UIFont systemFontOfSize:kFontSize];
//        _leftButtonTitleLabel.textColor = [UIColor blackColor];
//        _leftButtonTitleLabel.textAlignment = NSTextAlignmentCenter;
//        [_leftButton addSubview:_leftButtonTitleLabel];
//        _leftButtonTitleLabel.frame = CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//        [_leftButtonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(0);
//            make.left.offset(0);
//            make.centerY.equalTo(_leftButton.mas_centerY);
//        }];
    }
    return _leftButton;
}

//- (UIButton *)rightButton {
//    if (!_rightButton) {
//        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _rightButton.hidden = YES;
//        [_rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
//        _rightButtonImageView = [[UIImageView alloc] init];
//        [_rightButton addSubview:_rightButtonImageView];
//        [_rightButtonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-kHorizontalMargin);
//            make.left.offset(kHorizontalMargin);
//            make.centerY.equalTo(_rightButton.mas_centerY);
//        }];
//
//        _rightButtonTitleLabel = [[UILabel alloc] init];
//        _rightButtonTitleLabel.font = [UIFont systemFontOfSize:kFontSize];
//        _rightButtonTitleLabel.textColor = [UIColor blackColor];
//        [_rightButton addSubview:_rightButtonTitleLabel];
//        [_rightButtonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-kHorizontalMargin);
//            make.left.offset(kHorizontalMargin);
//            make.centerY.equalTo(_rightButton.mas_centerY);
//        }];
//    }
//    return _rightButton;
//}

@end
