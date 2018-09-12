//
//  LXUserInfoDataController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXUserInfoResponseObject;
@class LXSaveUserInfoResponseObject,LXAppCoachLogoutResponseObject;

@interface LXUserInfoDataController : NSObject


/**
 获取教练信息接口

 @param certNo 教练证
 @param block LXUserInfoResponseObject
 */
- (void)lxReuqestUserInfoWithCertNo:(NSString *)certNo completionBlock:(void(^)(LXUserInfoResponseObject *responseModel))block;


/**
 保存教练个人简介信息

 @param certNo 教练证
 @param present 个人简介
 @param block LXSaveUserInfoResponseObject
 */
- (void)lxReuqestSaveUserInfoWithCertNo:(NSString *)certNo present:(NSString *)present completionBlock:(void(^)(LXSaveUserInfoResponseObject *responseModel))block;


/**
 退出登录

 @param block block
 */
- (void)lxRequestAppCoachLogoutCompletionBlock:(void(^)(LXAppCoachLogoutResponseObject *responseModel))block;


@end
