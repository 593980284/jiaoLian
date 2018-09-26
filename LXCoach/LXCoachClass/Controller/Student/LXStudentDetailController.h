//
//  LXStudentDetailController.h
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXMyStudentListModel;
/**
 我的学员详情
 */
@interface LXStudentDetailController : UIViewController

@property (nonatomic, strong)LXMyStudentListModel *headerModel;
/// yes:需要传 no:不需要传
@property (nonatomic, assign) BOOL cerNoState;
@end
