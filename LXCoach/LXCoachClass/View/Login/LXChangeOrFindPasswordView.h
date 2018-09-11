//
//  LXChangeOrFindPasswordView.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXChangeOrFindPasswordViewDelegate <NSObject>
/**
 获取验证码

 @param testCodeButton  按钮
 @param phoneNumber     电话号码
 */
- (void)lx_obtainTestCodeButton:(UIButton *)testCodeButton andPhoneNumber:(NSString *)phoneNumber;
/**
 点击确认

 @param  testCode 验证码
 @param  phoneNumber 手机号
 */
- (void)lx_clickAffirmButton:(NSString *)testCode andPhoneNumber:(NSString *)phoneNumber;
@end

@interface LXChangeOrFindPasswordView : UIView
@property (nonatomic, assign) id <LXChangeOrFindPasswordViewDelegate> delegate;
@property (nonatomic, strong) UITextField *acountTextField;
@end
