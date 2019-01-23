//
//  LXStudentDetail_Cell.h
//  LXCoach
//
//  Created by slardar on 2019/1/23.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMyStudentDetailSubjectModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXStudentDetail_Cell : UITableViewCell
- (void)updateWithModel:(LXMyStudentDetailModel *)model andSubjectName:(NSString *)subName;
@end

NS_ASSUME_NONNULL_END
