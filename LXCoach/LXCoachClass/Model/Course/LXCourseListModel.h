//
//  LXCourseListModel.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 我的课程（我的课程根据日期查询排课接口）
 */
@interface LXCourseListModel : NSObject

/// 科目名称
@property (nonatomic, copy)   NSString *subjectName;
/// 课程id
@property (nonatomic, assign) NSInteger appointmentId;
/// 约课时间段
@property (nonatomic, copy)   NSString *periodTime;
/// 报名人数
@property (nonatomic, assign) NSInteger appointmentNum;
/// 剩余人数
@property (nonatomic, assign) NSInteger noAppointmentNum;

/**
 {
 "flg": 1,
 "msg": "查询成功!",
 "data": {
 "list": [
 {
 "appointmentId": 23,
 "subjectName": "科目二",
 "periodTime": "2018-09-07 09:00:00-11:00:00",
 "appointmentNum": 3,
 "noAppointmentNum": 1
 }
 ]
 }
 }}

 */
@end






