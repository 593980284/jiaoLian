//
//  LXNavigationManager.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNavigationManager : NSObject

+ (UINavigationController *)lx_currentNavigationController;

+ (UIViewController *)lx_currentController;

@end
