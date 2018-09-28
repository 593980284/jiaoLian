//
//  LXSearchCourseRecordJudgeModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/18.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 查询课程记录评价
 */
@interface LXSearchCourseRecordJudgeModel : NSObject
/// 约课记录id
@property (nonatomic, assign) NSInteger courseRecordId;
/// 课程评价分数
@property (nonatomic, assign)NSInteger studentScore;
/// 课程评价内容
@property (nonatomic, copy) NSString *studentEvaluationContent;

/// 学员名称
@property (nonatomic, copy) NSString *studentName;

@end
