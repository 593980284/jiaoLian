//
//  LXMessageListCell.h
//  LXCoach
//
//  Created by GDD on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXFindCoachMsgModel;
@interface LXMessageListCell : UITableViewCell

- (void)configMessagListValue:(LXFindCoachMsgModel *)model;

@end
