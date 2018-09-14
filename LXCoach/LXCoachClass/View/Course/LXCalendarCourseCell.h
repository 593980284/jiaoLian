//
//  LXCalendarCourseCell.h
//  LXCoach
//
//  Created by GDD on 2018/9/14.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseFindDateListModel;
@interface LXCalendarCourseCell : UICollectionViewCell
/// 日期
@property (nonatomic, strong) UILabel *dateLabel;
- (void)congfigCourseFindDateListModel:(LXCourseFindDateListModel *)model;

@end
