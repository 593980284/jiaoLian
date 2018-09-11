//
//  LXUrlApi.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#ifndef LXUrlApi_h
#define LXUrlApi_h

/// baseURL
static NSString * const kBaseUrl = @"http://111.39.245.156:8087/app/lexiang/";
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

///  保存教练个人简介信息
static NSString * const kSaveUserInfo = @"coachSetting/saveCoachInfo";
/// 查询我的课程日期列表
static NSString * const kfindMyCouseDateList = @"course/findMyCouseDateList";
/// 教练上传头像图片接口
static NSString * const kUploadCoachImage = @"coachSetting/uploadCoachImage";




#endif /* LXUrlApi_h */
