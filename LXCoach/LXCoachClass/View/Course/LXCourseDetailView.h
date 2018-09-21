//
//  LXCourseDetailView.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseDetailModel;
@class LXCourseToStudentModel;

@protocol LXCourseDetailViewDelegate <NSObject>

- (void)lx_button1Click:(NSIndexPath *)indexPath;
- (void)lx_button2Click:(NSIndexPath *)indexPath;

@end

@interface LXCourseDetailView : UIView

@property (nonatomic, assign) id <LXCourseDetailViewDelegate> delegate;

/// 对应科目的所有学员
@property (nonatomic, strong) NSArray <LXCourseToStudentModel*> *courseDetailArr;

/// 头部的model
@property (nonatomic, strong) LXCourseDetailModel *topSubjectModel;
 /*
0：未评价
1：评价
*/
@property (nonatomic, assign) NSInteger isEvaluate;
/// 区分查看的是我的学员还是查看评价详情 1:学员详情 2:查看评价
@property (nonatomic, assign) NSInteger cheekPageOption;
@end
