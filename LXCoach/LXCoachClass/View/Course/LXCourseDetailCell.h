//
//  LXCourseDetailCell.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseToStudentModel;

@interface LXCourseDetailCell : UITableViewCell
@property (nonatomic, strong) LXCourseToStudentModel *courseStudentModel;
@property (nonatomic, copy) void (^studentOperationBtn1Block)(void);
@property (nonatomic, copy) void (^studentOperationBtn2Block)(void);
@end
