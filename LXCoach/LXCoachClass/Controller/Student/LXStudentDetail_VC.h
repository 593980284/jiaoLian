//
//  LXStudentDetail_VC.h
//  LXCoach
//
//  Created by slardar on 2019/1/22.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMyStudentListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXStudentDetail_VC : UIViewController
@property (nonatomic, strong) LXMyStudentListModel *headerModel;
/// yes:需要传 no:不需要传
@property (nonatomic, assign) BOOL cerNoState;
@end

NS_ASSUME_NONNULL_END
