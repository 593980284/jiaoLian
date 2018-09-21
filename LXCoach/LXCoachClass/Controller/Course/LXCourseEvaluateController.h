//
//  LXCourseEvaluateController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  LXCourseListModel,LXCourseDetailModel,LXSearchCourseRecordJudgeModel,LXCourseToStudentModel;
/**
 课程评价
 */
@interface LXCourseEvaluateController : UIViewController
/// 头部的model
@property (nonatomic, strong) LXCourseDetailModel *topSubjectModel;
/// 学员相关信息
@property (nonatomic, strong) NSArray <LXCourseToStudentModel *> *studentListArr;
/*
 0：未评价
 1：评价
 */
@property (nonatomic, assign) NSInteger isEvaluate;

/**
 区分查看评价还是进行评价
 1：课程评价
 2：查看课程评价
 */
@property (nonatomic, assign) NSInteger courseJudgeType;

/// 查看课程评价的model
@property (nonatomic, strong) LXSearchCourseRecordJudgeModel *readCourseRecordModel;

/// 约课记录id
@property (nonatomic, assign) NSInteger courseRecordId;

@end
