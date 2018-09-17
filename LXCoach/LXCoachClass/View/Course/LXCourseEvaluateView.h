//
//  LXCourseEvaluateView.h
//  LXCoach
//
//  Created by GDD on 2018/9/10.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseListModel,LXCourseDetailModel;

@protocol LXCourseEvaluateViewDelegate <NSObject>
/**
提交评价

 @param courseRecordIds 约课记录id
 @param studentScores 课程评价分数
 @param studentEvaluationContents 课程评价内容
 */
- (void)lx_courseAssessSubmitCourseRecordIds:(NSMutableArray *)courseRecordIds andStudentScores:(NSMutableArray *)studentScores andStudentEvaluationContents:(NSMutableArray *)studentEvaluationContents;

@end

@interface LXCourseEvaluateView : UIView

@property (nonatomic, assign) id <LXCourseEvaluateViewDelegate> delegate;
/// 头部的model
@property (nonatomic, strong) LXCourseListModel *topSubjectModel;
/// 学员listArr
@property (nonatomic, strong) NSArray <LXCourseDetailModel *> *courseListDetaileArr;

@end
