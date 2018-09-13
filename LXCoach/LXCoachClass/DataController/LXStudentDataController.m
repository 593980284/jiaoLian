//
//  LXStudentDataController.m
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXStudentDataController.h"
#import "LXFindMyStudentSessionTask.h"
#import "LXFindMyStudentDetilSessionTask.h"

@implementation LXStudentDataController
/**
 我的学员列表
 
 @param certNo 教练证号
 @param block responseModel
 */
- (void)lxReuqestFindMyStudentListWithCertNo:(NSString *)certNo completionBlock:(void(^)(LXFindMyStudentResponseObject *responseModel))block {
    LXFindMyStudentSessionTask *task = [[LXFindMyStudentSessionTask alloc] init];
    task.certNo = certNo;
    [task lxReuqestFindMyStudentWithCompletionBlock:^(LXFindMyStudentResponseObject *responseModel) {
        block(responseModel);
    }];
}

/**
 学员详情
 
 @param certNo 教练证号
 @param studentId 学员id
 @param block responseModel
 */
- (void)lxReuqestFindMyStudentDetilWithCertNo:(NSString *)certNo andStudentId:(NSString *)studentId completionBlock:(void(^)(LXFindMyStudentDetilResponseObject *responseModel))block {
    LXFindMyStudentDetilSessionTask *task = [[LXFindMyStudentDetilSessionTask alloc] init];
    task.certNo = certNo;
    task.certNo = studentId;
    [task lxReuqestFindMyStudentDetilWithCompletionBlock:^(LXFindMyStudentDetilResponseObject *responseModel) {
        block(responseModel);
    }];
    
}
@end
