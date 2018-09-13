//
//  LXStudentDataController.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXFindMyStudentResponseObject,LXFindMyStudentDetilResponseObject;
/**
 我的学员请求DataController
 */
@interface LXStudentDataController : NSObject

/**
 我的学员列表

 @param certNo 教练证号
 @param block responseModel
 */
- (void)lxReuqestFindMyStudentListWithCertNo:(NSString *)certNo completionBlock:(void(^)(LXFindMyStudentResponseObject *responseModel))block;

/**
 学员详情

 @param certNo 教练证号
 @param studentId 学员id
 @param block responseModel
 */
- (void)lxReuqestFindMyStudentDetilWithCertNo:(NSString *)certNo andStudentId:(NSString *)studentId completionBlock:(void(^)(LXFindMyStudentDetilResponseObject *responseModel))block;
@end
