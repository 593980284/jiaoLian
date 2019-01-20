//
//  LXAffairsHandleSessionTask.h
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXAffairsHandleResponseObject;
NS_ASSUME_NONNULL_BEGIN

@interface LXAffairsHandleSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy) NSString *certNo;
/// 日期
@property (nonatomic, copy) NSString *date;

- (void)lxReuqestWithCompletionBlock:(void(^)(LXAffairsHandleResponseObject *responseModel))block;

@end

@interface LXAffairsHandleResponseObject : LXNetWorkResponseBaseObject

@end
NS_ASSUME_NONNULL_END
