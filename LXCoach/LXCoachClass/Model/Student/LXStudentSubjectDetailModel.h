//
//  LXStudentSubjectDetailModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 科目状态详情model
 */
@interface LXStudentSubjectDetailModel : NSObject
/**  状态
2，6：已到
3，7：缺勤
1，4，5：未确认
10：已取消
 */
@property (nonatomic, assign) NSInteger status;

/// 日期
@property(nonatomic, copy) NSString *date;
/// 时间
@property(nonatomic, copy) NSString *time;

@end
