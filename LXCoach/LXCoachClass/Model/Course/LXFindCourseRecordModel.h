//
//  LXFindCourseRecordModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 查询教练课程记录
 */
@interface LXFindCourseRecordModel : NSObject
/// 驾校名称
@property (nonatomic, copy) NSString *schoolName;
/// 约课id
@property (nonatomic, copy) NSString *appointmentId;
/// 驾校id
@property (nonatomic, copy) NSString *schoolId;
/// 科目id
@property (nonatomic, copy) NSString *subjectId;
/// 科目名称
@property (nonatomic, copy) NSString *subjectName;
/// 约课时间段
@property (nonatomic, copy) NSString *periodTime;
/// 教练头像路径
@property (nonatomic, copy) NSString *coachPhoto;
/// 到达学员
@property (nonatomic, assign) NSInteger reachStuNum;
/// 未到达学员
@property (nonatomic, assign) NSInteger noReachStuNum;
/// 学时
@property (nonatomic, assign) NSInteger hours;
/// 课程状态 0:已完成 1:未完成
@property (nonatomic, assign) NSInteger courseState;

@end
