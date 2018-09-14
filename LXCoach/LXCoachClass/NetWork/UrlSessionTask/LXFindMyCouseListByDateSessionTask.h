//
//  LXFindMyCouseListByDateSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/14.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXFindMyCouseListByDateResponseObject;

/**
 我的课程根据日期查询排课
 */
@interface LXFindMyCouseListByDateSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy) NSString *certNo;
/// 日期
@property (nonatomic, copy) NSString *date;

- (void)lxReuqestFindMyCouseListByDateWithCompletionBlock:(void(^)(LXFindMyCouseListByDateResponseObject *responseModel))block;

@end

@interface LXFindMyCouseListByDateResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, copy) NSDictionary *data;
@end
