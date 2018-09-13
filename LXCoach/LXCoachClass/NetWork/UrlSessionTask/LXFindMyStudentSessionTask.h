//
//  LXFindMyStudentSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"

@class LXMyStudentListModel;
@class LXFindMyStudentResponseObject;

/**
 查询我的学员列表
 */
@interface LXFindMyStudentSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy) NSString *certNo;

- (void)lxReuqestFindMyStudentWithCompletionBlock:(void(^)(LXFindMyStudentResponseObject *responseModel))block;

@end

@interface LXFindMyStudentResponseObject : LXNetWorkResponseBaseObject

@property (nonatomic, copy) NSDictionary *data;

@end
