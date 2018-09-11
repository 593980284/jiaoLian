//
//  LXAlterMessageCell.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXAlterMessageCell : UITableViewCell
@property (nonatomic, copy)NSString *imageName;
@property (nonatomic, copy)NSString *nameString;
/**
 隐藏对应的view

 @param type 1:隐藏label； 2:隐藏imageView
 */
- (void)hiddenCurrenViewType:(NSInteger)type;
@end
