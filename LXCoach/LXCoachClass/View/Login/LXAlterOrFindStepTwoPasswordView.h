//
//  LXAlterOrFindStepTwoPasswordView.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol LXAlterOrFindStepTwoPasswordViewDelegate <NSObject>
/**
 修改/找回密码（第二步）

 @param oldPassword 以前的密码
 @param newPassword 新密码
 @param affirmPassword 确认新密码
 */
- (void)lx_clickAffirmOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)newPassword andAffirmPassword:(NSString *)affirmPassword;
@end

@interface LXAlterOrFindStepTwoPasswordView : UIView
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign)id <LXAlterOrFindStepTwoPasswordViewDelegate> delegate;
/**
 根据type值调整界面

 @param type type=1 忘记密码确认密码第二步； type=2 修改密码
 */
- (void)adjustmentViewType:(NSInteger)type;
@end
