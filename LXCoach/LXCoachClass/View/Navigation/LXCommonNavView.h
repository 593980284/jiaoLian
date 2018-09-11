//
//  LXCommonNavView.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXCommonNavViewDelegate<NSObject>

@optional
- (void)lx_clickLeftButton;
- (void)lx_clickRightButton;

@end

/**
 通用导航栏
 */
@interface LXCommonNavView : UIView

@property (nonatomic, weak) id<LXCommonNavViewDelegate> delegate;

/** 左侧按钮文字 */
@property (nonatomic, copy)   NSString *leftButtonTitle;
/** 左侧按钮颜色 */
@property (nonatomic, strong) UIColor *leftButtonTitleColor;
/** 右侧按钮文字 */
@property (nonatomic, copy)   NSString *rightButtonTitle;
/** 右侧按钮颜色 */
@property (nonatomic, strong) UIColor *rightButtonTitleColor;
/** 左侧按钮图片 */
@property (nonatomic, strong) UIImage *leftButtonImage;
/** 右侧按钮图片 */
@property (nonatomic, strong) UIImage *rightButtonImage;
/** 是否返回显示返回按钮 */
@property (nonatomic, assign) BOOL showBackButton;


- (instancetype)initWithTitle:(NSString *)title;
/**
 修改标题颜色
 
 @param titleColor 标题颜色
 */
- (void)changeTitleColor:(UIColor *)titleColor;

/**
 隐藏底部阴影分割线
 */
- (void)hiddenSeprateLine;

/**
 显示底部阴影分割线
 */
- (void)showSeprateLine;

/**
 更新导航栏标题
 
 @param title 标题
 */
- (void)updateNavigationTitle:(NSString *)title;
@end
