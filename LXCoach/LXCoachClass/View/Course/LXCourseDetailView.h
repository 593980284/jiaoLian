//
//  LXCourseDetailView.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseDetailModel;
@class LXCourseListModel;

@interface LXCourseDetailView : UIView

@property (nonatomic, strong) LXCourseDetailModel *courseDetailModel;

@property (nonatomic, strong) LXCourseListModel *topSubjectModel;
@end
