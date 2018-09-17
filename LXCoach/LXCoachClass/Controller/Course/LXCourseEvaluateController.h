//
//  LXCourseEvaluateController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  LXCourseListModel,LXCourseDetailModel;
/**
 课程评价
 */
@interface LXCourseEvaluateController : UIViewController
/// 头部的model
@property (nonatomic, strong) LXCourseListModel *topSubjectModel;
/// 学员相关信息
@property (nonatomic, strong) NSArray <LXCourseDetailModel *> *studentListArr;
/*
 0：未评价
 1：评价
 */
@property (nonatomic, assign) NSInteger isEvaluate;



@end
