//
//  LXCourseEvaluateView.h
//  LXCoach
//
//  Created by GDD on 2018/9/10.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseListModel,LXCourseDetailModel,LXSearchCourseRecordJudgeModel,LXCourseToStudentModel;

@protocol LXCourseEvaluateViewDelegate <NSObject>
/**
提交评价

 @param courseRecordIds 约课记录id
 @param studentScores 课程评价分数
 @param studentEvaluationContents 课程评价内容
 */
- (void)lx_courseAssessSubmitCourseRecordIds:(NSMutableArray *)courseRecordIds andStudentScores:(NSMutableArray *)studentScores andStudentEvaluationContents:(NSMutableArray *)studentEvaluationContents;

/**
 课程记录进入---单个课程评价

 @param studentScore 课程评价分数
 @param studentEvaluationContent 课程评价内容
 */
- (void)lx_singleCourseRecordSubmitStudentScore:(NSInteger)studentScore andStudentEvaluationContent:(NSString *)studentEvaluationContent;

@end

@interface LXCourseEvaluateView : UIView

@property (nonatomic, assign) id <LXCourseEvaluateViewDelegate> delegate;
/// 头部的model
@property (nonatomic, strong) LXCourseDetailModel *topSubjectModel;
/// 学员listArr
@property (nonatomic, strong) NSArray <LXCourseToStudentModel *> *courseListDetaileArr;

/**
 区分查看评价还是进行评价
 1：课程评价
 2：查看课程评价
 */
@property (nonatomic, assign) NSInteger courseJudgeType;

/// 查看课程评价的model
@property (nonatomic, copy) LXSearchCourseRecordJudgeModel *readCourseRecordModel;

@end
