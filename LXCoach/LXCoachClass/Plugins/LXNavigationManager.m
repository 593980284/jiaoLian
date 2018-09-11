//
//  LXNavigationManager.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXNavigationManager.h"
#import "UIWindow+LXUIWindow.h"

@implementation LXNavigationManager

+ (UINavigationController *)lx_currentNavigationController {
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        if (window.windowLevel == UIWindowLevelNormal) {
            UIViewController *visibleViewController = window.lx_currentVisibleController;
            return visibleViewController.navigationController;
        }
    }
    return nil;
}

+ (UIViewController *)lx_currentController {
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        if (window.windowLevel == UIWindowLevelNormal) {
            UIViewController *visibleViewController = window.lx_currentVisibleController;
            return visibleViewController;
        }
    }
    return nil;
}

@end
