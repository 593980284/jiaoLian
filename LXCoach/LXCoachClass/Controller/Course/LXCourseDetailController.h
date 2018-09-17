//
//  LXCourseDetailController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseListModel;

/**
 课程详情
 */
@interface LXCourseDetailController : UIViewController

@property (nonatomic, strong) LXCourseListModel *courseSubjectModel;

/// 区分查看的是我的学员还是查看评价详情 1:学员详情 2:查看评价
@property (nonatomic, assign) NSInteger cheekPageOption;
@end
