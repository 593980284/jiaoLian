//
//  LXCourseDetailModel.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCourseDetailModel : NSObject
/// 约课时间段
@property (nonatomic, copy)   NSString *periodTime;
/// 报名人数
@property (nonatomic, assign) NSInteger appointmentNum;
/// 剩余人数
@property (nonatomic, assign) NSInteger noAppointmentNum;
@property (nonatomic, strong) NSArray *list;
/**
 {
 "flg": 1,
 "msg": "查询成功!",
 "data": {
 "periodTime": "2018-09-05 17:00:00-19:00:00",
 "appointmentNum": 3,
 "noAppointmentNum": 1,
 "list": [
 {
 "studentName": "王秋萍",
 "studentPhoto": "files/stuimg/20170525_152301199801233727B.jpg",
 "courseRecordId": 2,
 "subjectId": 2,
 "subjectName": "科目二",
 "status": "2",
 "hours": 2
 },
 ……
 ]
 }
 }}

 */
@end

@interface LXCourseStudentModel : NSObject
/// 学员名称
@property (nonatomic, copy)   NSString *studentName;
/// 学员相片路径
@property (nonatomic, copy)   NSString *studentPhoto;
/// 学员评分
@property (nonatomic, copy)   NSString *studentScore;
/// 约课记录id
@property (nonatomic, assign) NSInteger courseRecordId;
//// 科目id
@property (nonatomic, assign) NSInteger subjectId;
/// 科目名称
@property (nonatomic, copy)   NSString *subjectName;
/// 状态 2，6：已到 3，7：缺勤 5：未确认 1，4显示已到和缺勤按钮，调用接口1.1.8
@property (nonatomic, copy)   NSString *status;
/// 学时
@property (nonatomic, assign) NSInteger hours;

@end
