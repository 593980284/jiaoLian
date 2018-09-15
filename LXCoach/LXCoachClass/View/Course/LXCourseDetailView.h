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

@protocol LXCourseDetailViewDelegate <NSObject>

- (void)lx_button1Click:(NSIndexPath *)indexPath;
- (void)lx_button2Click:(NSIndexPath *)indexPath;

@end

@interface LXCourseDetailView : UIView

@property (nonatomic, assign) id <LXCourseDetailViewDelegate> delegate;
/// 对应科目的所有学员
@property (nonatomic, strong) NSArray <LXCourseDetailModel*> *courseDetailArr;

@property (nonatomic, strong) LXCourseListModel *topSubjectModel;
 /*
0：未评价
1：评价
*/
@property (nonatomic, assign) NSInteger isEvaluate;

@end
