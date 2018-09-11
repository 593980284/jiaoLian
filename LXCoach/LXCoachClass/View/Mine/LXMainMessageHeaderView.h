//
//  LXMainMessageHeaderView.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXMineModel;

@interface LXMainMessageHeaderView : UIView
@property (nonatomic, copy) void (^clickHeadActionBlock)(void);
- (void)assignmentMineHeaderValue:(LXMineModel *)headerModel;
@end
