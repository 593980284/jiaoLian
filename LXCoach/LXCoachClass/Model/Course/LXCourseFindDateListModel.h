//
//  LXCourseFindDateListModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 查询我的课程日期列表Model
 */
@interface LXCourseFindDateListModel : NSObject
/// 时间
@property (nonatomic, copy)NSString *date;
///0：无排课  1：有排课
@property (nonatomic, assign)NSInteger has;
@end
