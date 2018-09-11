//
//  UIWindow+LXUIWindow.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (LXUIWindow)

/**
 获取当前窗口可见ViewController
 */
- (UIViewController *)lx_currentVisibleController;

@end
