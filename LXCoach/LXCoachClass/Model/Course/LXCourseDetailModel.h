//
//  LXCourseDetailModel.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 我的课程课程详情 --- 学生列表
 */
@interface LXCourseDetailModel : NSObject
/**
 0：未评价
 1：评价
*/
@property (nonatomic, assign) NSInteger isEvaluate;
/// 课程id
@property (nonatomic, assign) NSInteger appointmentId;
/// 科目id
@property (nonatomic, assign) NSInteger subjectId; 
/// 科目名称
@property (nonatomic, copy) NSString *subjectName;
/// 约课时间段
@property (nonatomic, copy) NSString *periodTime;
/// 报名人数
@property (nonatomic, copy) NSString *appointmentNum;
/// 剩余人数
@property (nonatomic, assign) NSInteger noAppointmentNum;
/// 学员列表
@property (nonatomic, strong) NSArray *list;
@end

@interface LXCourseToStudentModel : NSObject

/// 学员名称
@property (nonatomic, copy)   NSString *studentName;
/// 学员相片路径
@property (nonatomic, copy)   NSString *studentPhoto;
/// 学员评分
@property (nonatomic, copy)   NSString *studentScore;
/// 学员id
@property (nonatomic, copy) NSString *studentId;
/// 约课记录id
@property (nonatomic, assign) NSInteger courseRecordId;
//// 科目id
@property (nonatomic, assign) NSInteger subjectId;
/// 科目名称
@property (nonatomic, copy)   NSString *subjectName;
/**
 0：已预约（显示状态）
 1：学员点击了签到（显示已到、缺勤按钮）
 4：学员未点击签到（显示已到、缺勤按钮）
 2，6：已到（显示状态）
 3，7：缺勤（显示状态）
 5：未确认（显示状态）
 */
@property (nonatomic, assign)   NSInteger status;
/// 学时
@property (nonatomic, assign) NSInteger hours;
/// 学员手机号
@property (nonatomic, copy) NSString *mobile;
/*
 0：未评价
 1：评价
 */
@property (nonatomic, assign) NSInteger isEvaluate;

@end

