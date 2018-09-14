//
//  LXFindMyCouseDateListSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXFindMyCouseDateListResponseObject;

/**
 查询我的课程日期列表
 */
@interface LXFindMyCouseDateListSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy) NSString *certNo;

- (void)lxReuqestFindMyCouseDateListWithCompletionBlock:(void(^)(LXFindMyCouseDateListResponseObject *responseModel))block;

@end

@interface LXFindMyCouseDateListResponseObject : LXNetWorkResponseBaseObject

@property (nonatomic, strong)  NSDictionary *data;

@end
