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

@end
