//
//  LXFindMyCouseDetailListSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/14.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXFindMyCouseDetailListResponseObject;

/**
 查询我的课程课程详情
 */
@interface LXFindMyCouseDetailListSessionTask : LXBaseUrlSessionTask
/// 约课id
@property (nonatomic, copy) NSString *appointmentId;

- (void)lxReuqestFindMyCouseDetailListWithCompletionBlock:(void(^)(LXFindMyCouseDetailListResponseObject *responseModel))block;

@end

@interface LXFindMyCouseDetailListResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, assign) NSInteger  isEvaluate;

@end
