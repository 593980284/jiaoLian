//
//  LXChangeOrFindPasswordController.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 更换或找回密码
 */
@interface LXChangeOrFindPasswordController : UIViewController

// 1: 找回密码第一步； 2: 更换手机号第一步 3: 更换手机号第二步
@property (nonatomic, assign) NSInteger type;
@end
