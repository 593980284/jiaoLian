//
//  LXLoginView.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXLoginViewDelegete  <NSObject>
@optional
/**
 点击账号密码登录
 */
- (void)lx_clickAcountPasswordLoginButton;

/**
 点击快捷登录
 */
- (void)lx_clickAoucntSpeedyLoginButton;

/**
 点击登录按钮

 @param acount 账号
 @param code 密码或者验证码
 */
- (void)lx_clickLoginButton:(NSString *)acount andPasswordOrTestCode:(NSString *)code;

/**
 点击忘记密码按钮
 */
- (void)lx_clickForgetPasswordButton;

/**
 获取验证码

 @param codeButton button
 */
- (void)lx_obtainCodeTextCode:(UIButton *)codeButton;


@end

@interface LXLoginView : UIView

@property (nonatomic, assign) id <LXLoginViewDelegete> delegate;

@end
