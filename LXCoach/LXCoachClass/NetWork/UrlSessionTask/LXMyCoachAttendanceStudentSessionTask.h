//
//  LXMyCoachAttendanceStudentSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/15.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"

@class LXMyCoachAttendanceStudentResponseObject;

/**
 我的课程教练对学员的课程考勤
 */
@interface LXMyCoachAttendanceStudentSessionTask : LXBaseUrlSessionTask
/// 约课记录id
@property (nonatomic, copy) NSNumber *courseRecordId;
/// 课程考勤状态
@property (nonatomic, copy) NSNumber *status;

- (void)lxReuqestMyCoachAttendanceStudentWithCompletionBlock:(void(^)(LXMyCoachAttendanceStudentResponseObject *responseModel))block;

@end

@interface LXMyCoachAttendanceStudentResponseObject : LXNetWorkResponseBaseObject

@end
