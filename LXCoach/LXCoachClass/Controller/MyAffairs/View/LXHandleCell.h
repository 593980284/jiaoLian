//
//  LXHandleCell.h
//  LXCoach
//
//  Created by slardar on 2019/1/21.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXAffairsHandleModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol LXHandleCellDelegate <NSObject>

- (void)cellActionWithModel:(LXAffairsHandleSSlist *)model andType:(NSInteger)type;

@end
@interface LXHandleCell : UITableViewCell
@property (nonatomic,weak) id<LXHandleCellDelegate> delegate;
- (void)updateWithModel:(LXAffairsHandleSSlist *)model andRowIndex:(NSInteger)rowIndex;
@end

NS_ASSUME_NONNULL_END
