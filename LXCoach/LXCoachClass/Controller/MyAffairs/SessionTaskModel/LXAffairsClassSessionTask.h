//
//  LXAffairsClassSessionTask.h
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXAffairsClassResponseObject;
NS_ASSUME_NONNULL_BEGIN

@interface LXAffairsClassSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy) NSString *certNo;

- (void)lxReuqestWithCompletionBlock:(void(^)(LXAffairsClassResponseObject *responseModel))block;
@end

@interface LXAffairsClassResponseObject : LXNetWorkResponseBaseObject

@end
NS_ASSUME_NONNULL_END
