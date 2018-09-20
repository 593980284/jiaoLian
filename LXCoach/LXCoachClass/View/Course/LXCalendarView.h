//
//  LXCalendarView.h
//  LXCoach
//
//  Created by GDD on 2018/9/14.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseFindDateListModel;

/**
 根据所返日期View
 */
@interface LXCalendarView : UIView

@property (nonatomic, strong)NSMutableArray <LXCourseFindDateListModel *> *dataArr;

@property (nonatomic, copy) void (^collectionCellDidSelectBlock)(NSInteger);

@end
