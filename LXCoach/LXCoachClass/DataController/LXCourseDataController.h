//
//  LXCourseDataController.h
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXFindMyCouseDateListResponseObject,LXFindCoachCourseResponseObject;
@class LXFindMyCouseListByDateResponseObject;

@interface LXCourseDataController : NSObject

/**
 查询我的课程日期列表

 @param certNo 教练证号
 @param block responseModel
 */
- (void)lxReuqestFindMyCouseDateListWithCertNo:(NSString *)certNo completionBlock:(void(^)(LXFindMyCouseDateListResponseObject *responseModel))block;

/**
 查询教练课程记录列表

 @param certNo 教练证号
 @param block responseModel
 */
- (void)lxReuqestFindCoachCourseRecordListWithCertNo:(NSString *)certNo completionBlock:(void(^)(LXFindCoachCourseResponseObject *responseModel))block;

/**
 我的课程--根据日期查询排课

 @param certNo 教练证号
 @param date 日期
 @param block responseModel
 */
- (void)lxReuqestFindMyCouseListByDateWithCertNo:(NSString *)certNo andDate:(NSString *)date completionBlock:(void(^)(LXFindMyCouseListByDateResponseObject *responseModel))block;

@end
