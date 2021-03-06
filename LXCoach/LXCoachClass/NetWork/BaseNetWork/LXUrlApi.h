//
//  LXUrlApi.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#ifndef LXUrlApi_h
#define LXUrlApi_h
#ifdef DEBUG //处于开发测试阶段

/// baseURL
static NSString * const kBaseUrl = @"http://111.39.245.156:8087/app/lexiang/";
/// 图片地址
static NSString * const kBaseImageUrl = @"http://111.39.245.156:8087";

#else //处于发布正式阶段
/// baseURL
static NSString * const kBaseUrl = @"http://112.2.0.75:9001/app/lexiang/";
/// 图片地址
static NSString * const kBaseImageUrl = @"http://112.2.0.75:9001";

#endif
/// 教练账号密码接口
static NSString * const kLoginUrl = @"login/appCoachLogin";
/// 获得短信验证码接口
static NSString * const kCodeUrl = @"login/appMsgCode";
/// 教练员找回密码第一步
static NSString * const kFindPassWord = @"login/appCoachMsgCode";
///  教练员找回密码第二步（保存密码）
static NSString * const kSavePassWord = @"login/appSaveCoachPassword";
///  教练修改密码接口
static NSString * const kChangePassWord = @"coachSetting/appCoachChangePassWord";
///  教练员更换手机号第一步
static NSString * const kChangePhoneNum = @"coachSetting/appCoachCheckOldPhone";
///  教练员更换手机号第二步
static NSString * const kSavePhoneNum = @"coachSetting/appCoachCheckNewPhone";
///  获取教练信息接口
static NSString * const kUserInfo = @"coachSetting/getCoachInfo";
/// 退出登录
static NSString * const kAppCoachLogout = @"login/appCoachLogout";
///  保存教练个人简介信息
static NSString * const kSaveUserInfo = @"coachSetting/saveCoachInfo";
/// 教练上传头像图片接口
static NSString * const kUploadCoachImage = @"coachSetting/uploadCoachImage";
/// 检查更新
static NSString *const kVersionUpdate = @"homePage/versionUpdate";

// -------------- 课程 -----------------
/// 查询我的课程日期列表
static NSString * const kfindMyCouseDateList = @"course/findMyCouseDateList";
/// 我的课程根据日期查询排课
static NSString * const kfindMyCouseListByDate = @"course/findMyCouseListByDate";
/// 根据约约课id查询我的课程课程详情
static NSString * const kfindMyCouseDetailList =  @"course/findMyCouseDetailList";
/// 我的课程教练对学员的课程考勤
static NSString * const kMyCoachAttendanceStudent =  @"course/myCoachAttendanceStudent";
/// 提交我的课程评价
static NSString * const kMyCoachEvaluationStudents = @"course/myCoachEvaluationStudents";
/// 课程记录查询
static NSString * const kFindCoachCourseRecord = @"course/findCoachCourseRecord";
/// 查询教练课程记录评价
static NSString * const kFindCoachEvaluationStudent = @"course/findCoachEvaluationStudent";

static NSString * const kCoachEvaluationStudent = @"course/coachEvaluationStudent";

// -------------- 学员 -----------------
/// 我的学员列表
static NSString * const kFindMyStudentList = @"coach/findMyStudent";
/// 我的学员详情
static NSString * const kFindMyStudentDetil = @"coach/findMyStudentDetil";

// -------------- 我的事务 -----------------
/// 待处理课程接口
static NSString * const kFindMyAffairsToHandleList = @"course/findMyAffairsToHandleList";
/// 待上课接口
static NSString * const kFindMyAffairsToClassList = @"course/findMyAffairsToClassList";
/// 我的事务待处理日期接口
static NSString * const kFindMyAffairsToHandleDateList = @"course/findMyAffairsToHandleDateList";

// -------------- 消息 -----------------

/// 查询此教练消息列表
static NSString * const kFindCoachMsg = @"message/findCoachMsg";
// 查询此教练单个消息
static NSString * const kFindSingleCoachMsg = @"message/findSingleCoachMsg";

#endif /* LXUrlApi_h */
