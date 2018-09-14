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

@end
