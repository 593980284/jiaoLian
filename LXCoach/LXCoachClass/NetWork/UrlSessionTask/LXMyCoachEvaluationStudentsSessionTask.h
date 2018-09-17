//
//  LXMyCoachEvaluationStudentsSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/17.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"

@class LXMyCoachEvaluationStudentsResponseObject;
/**
 提交我的课程评价
 */
@interface LXMyCoachEvaluationStudentsSessionTask : LXBaseUrlSessionTask
/// 约课记录id (多个用英文逗号分割)
@property (nonatomic, copy) NSString *courseRecordIds;
/// 课程评价分数 (多个用英文逗号分割)
@property (nonatomic, copy) NSString *studentScores;
/// 课程评价内容 (多个用~!~分割)
@property (nonatomic, copy) NSString *studentEvaluationContents;

- (void)lxReuqestMyCoachEvaluationStudentsWithCompletionBlock:(void(^)(LXMyCoachEvaluationStudentsResponseObject *responseModel))block;

@end

@interface LXMyCoachEvaluationStudentsResponseObject : LXNetWorkResponseBaseObject

@end
