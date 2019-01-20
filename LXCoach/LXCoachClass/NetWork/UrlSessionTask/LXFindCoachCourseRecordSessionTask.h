//
//  LXFindCoachCourseRecordSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"

@class LXFindCoachCourseResponseObject,LXFindCourseRecordArrModel;

/**
 查询教练课程记录
 */
@interface LXFindCoachCourseRecordSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy)NSString *certNo;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger rows;

- (void)lxReuqestFindCoachCourseRecordWithCompletionBlock:(void(^)(LXFindCoachCourseResponseObject *responseModel))block;

@end

@interface LXFindCoachCourseResponseObject : LXNetWorkResponseBaseObject

@property (nonatomic, strong)  LXFindCourseRecordArrModel *data;

@end
