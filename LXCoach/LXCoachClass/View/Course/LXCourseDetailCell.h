//
//  LXCourseDetailCell.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCourseDetailModel;

@interface LXCourseDetailCell : UITableViewCell

@property (nonatomic, strong) LXCourseDetailModel *courseStudentModel;
/// 几颗星评价
@property (nonatomic, assign)NSInteger optionStartNumber;
@property (nonatomic, copy) void (^studentOperationBtn1Block)(void);
@property (nonatomic, copy) void (^studentOperationBtn2Block)(void);
@end
