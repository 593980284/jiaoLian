//
//  LXCourseListCell.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/7.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXFindCourseRecordModel;
/**
 课程记录cell
 */
@interface LXCourseListCell : UITableViewCell

/// 未完成课程的科目几加教龄
//@property (nonatomic, strong) UILabel *borderSubjectAge;

/// 赋值已完成课程
- (void)congfigCompletedValue:(LXFindCourseRecordModel *)completedCourseModel;

/// 赋值未完成课程
- (void)configNoHaveValue:(LXFindCourseRecordModel *)noHaveCourseModel;
@end
