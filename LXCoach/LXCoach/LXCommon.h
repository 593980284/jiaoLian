//
//  LXCommon.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#ifndef LXCommon_h
#define LXCommon_h

#define LXNavigationViewHeight 44

#define kAutoSizeScaleX [UIScreen mainScreen].bounds.size.width/375
#define kAutoSizeScaleY [UIScreen mainScreen].bounds.size.height/667

//字体相关
#define TEXT_FONT(F) [UIFont systemFontOfSize:F]
//颜色
#define UIColorWithHexAndAlpha(hex, a) [UIColor colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hex & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hex & 0xFF))/255.0 alpha:a]
//字体颜色 黄-蓝-红
#define TEXT_COLOR_BLACK UIColorWithHexAndAlpha(0x000000,1)//黑色字体
#define TEXT_COLOR_GRAY UIColorWithHexAndAlpha(0x666666,1)//灰色字体
#define TEXT_COLOR_YELLOW UIColorWithHexAndAlpha(0xff8c05,1)//黄色字体
#define TEXT_COLOR_BLUE UIColorWithHexAndAlpha(0x4498ff,1)//蓝色字体
#define TEXT_COLOR_RED UIColorWithHexAndAlpha(0xff4545,1)//红色字体
//背景颜色 黄-蓝-红
#define BG_COLOR_YELLOW UIColorWithHexAndAlpha(0xff8c05,1)//黄色背景
#define BG_COLOR_BLUE UIColorWithHexAndAlpha(0x4498ff,1)//蓝色背景
#define BG_COLOR_RED UIColorWithHexAndAlpha(0xff4545,1)//红色背景
#define BG_COLOR_GRAY UIColorWithHexAndAlpha(0xe3e3e3,1)//灰色背景

#endif /* LXCommon_h */
