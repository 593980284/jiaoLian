//
//  LXCoachEvaluationStudentSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/18.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXCoachEvaluationStudentResponseObject;
/**
 教练课程记录评价
 */
@interface LXCoachEvaluationStudentSessionTask : LXBaseUrlSessionTask
/// 约课记录id
@property (nonatomic, copy)NSNumber *courseRecordId;
/// 课程评价分数
@property (nonatomic, copy)NSNumber *studentScore;
/// 课程评价内容
@property (nonatomic, copy)NSString *studentEvaluationContent;

- (void)lxReuqestCoachEvaluationStudentWithCompletionBlock:(void(^)(LXCoachEvaluationStudentResponseObject *responseModel))block;

@end

@interface LXCoachEvaluationStudentResponseObject : LXNetWorkResponseBaseObject

@end
