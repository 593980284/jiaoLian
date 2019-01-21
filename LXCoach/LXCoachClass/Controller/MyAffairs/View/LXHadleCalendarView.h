//
//  LXHadleCalendarView.h
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXHadleCalendarView : UIView

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) void (^collectionCellDidSelectBlock)(NSInteger);

@end

NS_ASSUME_NONNULL_END
