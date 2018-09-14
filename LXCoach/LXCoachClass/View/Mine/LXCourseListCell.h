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

- (void)configCellValue:(LXFindCourseRecordModel *)model;

@end
