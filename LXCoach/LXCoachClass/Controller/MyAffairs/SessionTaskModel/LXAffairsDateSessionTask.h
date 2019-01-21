//
//  LXAffairsDateSessionTask.h
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXAffairsDateResponseObject;
@class LXAffairsDateModelList;
NS_ASSUME_NONNULL_BEGIN

@interface LXAffairsDateSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy) NSString *certNo;

- (void)lxReuqestWithCompletionBlock:(void(^)(LXAffairsDateResponseObject *responseModel))block;
@end

@interface LXAffairsDateResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, strong) LXAffairsDateModelList *data;
@end
NS_ASSUME_NONNULL_END
