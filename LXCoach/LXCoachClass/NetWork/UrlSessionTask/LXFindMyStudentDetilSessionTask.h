//
//  LXFindMyStudentDetilSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXFindMyStudentDetilResponseObject;
@class LXMyStudentDetailSubjectModel;
/**
   查询学员详情
 */
@interface LXFindMyStudentDetilSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy) NSString *certNo;
/// 学员id
@property (nonatomic, copy) NSString *studentId;

- (void)lxReuqestFindMyStudentDetilWithCompletionBlock:(void(^)(LXFindMyStudentDetilResponseObject *responseModel))block;

@end

@interface LXFindMyStudentDetilResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, copy) LXMyStudentDetailSubjectModel *data;
@end
