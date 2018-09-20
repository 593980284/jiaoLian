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

/// 星期
@property (nonatomic, copy) NSString  * week;
/// 某一天的日期
@property (nonatomic, copy) NSString  * oneDate;
// 年-月
@property (nonatomic, copy) NSString * yearAndMonth;
/// 默认第一个被选中 1:选中 0:不选中
@property (nonatomic, assign) NSInteger firstIsOption;
@end
