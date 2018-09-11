//
//  LXCourseDetailCell.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseStudentModel;

@interface LXCourseDetailCell : UITableViewCell

@property (nonatomic, strong) LXCourseStudentModel *courseStudentModel;
/// 几颗星评价
@property (nonatomic, assign)NSInteger optionStartNumber;
@end
