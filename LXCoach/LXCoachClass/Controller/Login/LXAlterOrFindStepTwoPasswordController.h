//
//  LXAlterOrFindStepTwoPasswordController.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 找回密码第二步 两个输入框
 修改密码 三个输入框
 */
@interface LXAlterOrFindStepTwoPasswordController : UIViewController
/// 1 忘记密码确认密码第二步； 2 修改密码
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *navTitleString;

@end
