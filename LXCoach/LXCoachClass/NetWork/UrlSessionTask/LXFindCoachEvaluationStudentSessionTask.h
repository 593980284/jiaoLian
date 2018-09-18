//
//  LXFindCoachEvaluationStudentSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/17.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"

@class LXFindCoachEvaluationStudentResponseObject;
@class LXSearchCourseRecordJudgeModel;

/**
 查询教练课程记录评价
 */
@interface LXFindCoachEvaluationStudentSessionTask : LXBaseUrlSessionTask
/// 约课记录id
@property (nonatomic, copy)NSString *courseRecordId;

- (void)lxReuqestFindCoachEvaluationStudentWithCompletionBlock:(void(^)(LXFindCoachEvaluationStudentResponseObject *responseModel))block;
@end


@interface LXFindCoachEvaluationStudentResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, strong)LXSearchCourseRecordJudgeModel *data;
@end
