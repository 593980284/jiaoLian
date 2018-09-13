//
//  LXStudentSubViewCell.h
//  LXCoach
//
//  Created by GDD on 2018/9/7.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXMyStudentListModel;
@interface LXStudentSubViewCell : UITableViewCell
@property (nonatomic, copy) void (^callMobileBlock)(void);

- (void)configStudentListModel:(LXMyStudentListModel *)model;

@end
