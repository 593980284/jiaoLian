//
//  LXStudentDetaileHeaderView.h
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXMyStudentListModel;

/**
 学院详情头部view
 */
@interface LXStudentDetaileHeaderView : UIView
/// 几颗星评价
//@property (nonatomic, assign)NSInteger optionStartNumber;

- (void)configValue:(LXMyStudentListModel *)model;

@end
