//
//  LXCourseDataController.m
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseDataController.h"
#import "LXFindMyCouseDateListSessionTask.h"
#import "LXFindCoachCourseRecordSessionTask.h"
#import "LXFindMyCouseListByDateSessionTask.h"
#import "LXFindMyCouseDetailListSessionTask.h"
#import "LXMyCoachAttendanceStudentSessionTask.h"
#import "LXMyCoachEvaluationStudentsSessionTask.h"

@implementation LXCourseDataController

/**
 查询我的课程日期列表
 
 @param certNo 教练证号
 @param block responseModel
 */
- (void)lxReuqestFindMyCouseDateListWithCertNo:(NSString *)certNo completionBlock:(void(^)(LXFindMyCouseDateListResponseObject *responseModel))block {
    LXFindMyCouseDateListSessionTask *task = [[LXFindMyCouseDateListSessionTask alloc] init];
    task.certNo = certNo;
    [task lxReuqestFindMyCouseDateListWithCompletionBlock:^(LXFindMyCouseDateListResponseObject *responseModel) {
        block(responseModel);
    }];
}


/**
 查询教练课程记录列表
 
 @param certNo 教练证号
 @param block responseModel
 */
- (void)lxReuqestFindCoachCourseRecordListWithCertNo:(NSString *)certNo completionBlock:(void(^)(LXFindCoachCourseResponseObject *responseModel))block {
    LXFindCoachCourseRecordSessionTask *task = [[LXFindCoachCourseRecordSessionTask alloc] init];
    task.certNo = certNo;
    [task lxReuqestFindCoachCourseRecordWithCompletionBlock:^(LXFindCoachCourseResponseObject *responseModel) {
        block(responseModel);
    }];
}


/**
 我的课程--根据日期查询排课
 
 @param certNo 教练证号
 @param date 日期
 @param block responseModel
 */
- (void)lxReuqestFindMyCouseListByDateWithCertNo:(NSString *)certNo andDate:(NSString *)date completionBlock:(void(^)(LXFindMyCouseListByDateResponseObject *responseModel))block {
    LXFindMyCouseListByDateSessionTask *task = [[LXFindMyCouseListByDateSessionTask alloc] init];
    task.certNo = certNo;
    task.date = date;
    [task lxReuqestFindMyCouseListByDateWithCompletionBlock:^(LXFindMyCouseListByDateResponseObject *responseModel) {
        block(responseModel);
    }];
}

/**
 查询我的课程课程详情
 
 @param appointmentId 约课id
 @param block block
 */
- (void)lxReuqestFindMyCouseDetailListWithAppointmentId:(NSString *)appointmentId completionBlock:(void(^)(LXFindMyCouseDetailListResponseObject *responseModel))block {
    LXFindMyCouseDetailListSessionTask *task = [[LXFindMyCouseDetailListSessionTask alloc] init];
    task.appointmentId = appointmentId;
    [task lxReuqestFindMyCouseDetailListWithCompletionBlock:^(LXFindMyCouseDetailListResponseObject *responseModel) {
        block(responseModel);
    }];
}

/**
 我的课程教练对学员的课程考勤
 
 @param courseRecordId 约课记录id
 @param status 课程考勤状态
 @param block block
 */
- (void)lxReuqestMyCoachAttendanceStudentWithCourseRecordId:(NSNumber *)courseRecordId andStatus:(NSNumber *)status completionBlock:(void(^)(LXMyCoachAttendanceStudentResponseObject *responseModel))block {
    LXMyCoachAttendanceStudentSessionTask *task = [[LXMyCoachAttendanceStudentSessionTask alloc] init];
    task.courseRecordId = courseRecordId;
    task.status = status;
    [task lxReuqestMyCoachAttendanceStudentWithCompletionBlock:^(LXMyCoachAttendanceStudentResponseObject *responseModel) {
        block(responseModel);
    }];
}

/**
 提交我的课程评价
 
 @param courseRecordIds 约课记录id组
 @param studentScores 课程评价分数组
 @param studentEvaluationContents 课程评价内容
 @param block block
 */
- (void)lxReuqestMyCoachEvaluationStudentsWithCourseRecordIds:(NSString *)courseRecordIds andStudentScores:(NSString *)studentScores andStudentEvaluationContents:(NSString *)studentEvaluationContents completionBlock:(void(^)(LXMyCoachEvaluationStudentsResponseObject *responseModel))block {
    LXMyCoachEvaluationStudentsSessionTask *task = [[LXMyCoachEvaluationStudentsSessionTask alloc] init];
    task.courseRecordIds = courseRecordIds;
    task.studentScores = studentScores;
    task.studentEvaluationContents = studentEvaluationContents;
    [task lxReuqestMyCoachEvaluationStudentsWithCompletionBlock:^(LXMyCoachEvaluationStudentsResponseObject *responseModel) {
        block(responseModel);
    }];
    
}

@end
