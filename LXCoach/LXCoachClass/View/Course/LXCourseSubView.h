//
//  LXCourseSubView.h
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseListModel;
@class LXCourseFindDateListModel;


@protocol LXCourseSubViewDelegate <NSObject>
/**
 点击对应的日期加载对应的数据

 @param index 点击的下标
 */
- (void)lx_courseDidDateReloadSource:(NSInteger)index;
@end

@interface LXCourseSubView : UIView
/// 日期Arr
@property (nonatomic, strong) NSArray <LXCourseFindDateListModel *> *dateArr;

/// 对应日期的课程Arr
@property (nonatomic, strong) NSArray <LXCourseListModel *>*dataSourse;

@property (nonatomic, assign) id <LXCourseSubViewDelegate> delegate;

@end
