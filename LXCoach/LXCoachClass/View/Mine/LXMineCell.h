//
//  LXMineCell.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXMineCell : UITableViewCell

/**
 给每个cell赋值

 @param value 对应的参数
 */
- (void)mineCellValuation:(NSDictionary *)value;
@end
