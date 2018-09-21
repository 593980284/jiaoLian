//
//  LXUserInfoDataController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXUserInfoDataController.h"
#import "LXUserInfoUrlSessionTask.h"
#import "LXSaveUserInfoUrlSessionTask.h"
#import "LXAppCoachLogoutSessionTask.h"
#import "LXVersionUpdateSessionTask.h"

@implementation LXUserInfoDataController

/**
 获取教练信息接口
 
 @param certNo 教练证
 @param block LXUserInfoResponseObject
 */
- (void)lxReuqestUserInfoWithCertNo:(NSString *)certNo completionBlock:(void(^)(LXUserInfoResponseObject *responseModel))block {
    LXUserInfoUrlSessionTask *userInfo = [LXUserInfoUrlSessionTask new];
    userInfo.certNo = certNo;
    [userInfo lxReuqestUserInfoWithCompletionBlock:^(LXUserInfoResponseObject *responseModel) {
        block(responseModel);
    }];
}

/**
 保存教练个人简介信息
 
 @param certNo 教练证
 @param present 个人简介
 @param block LXSaveUserInfoResponseObject
 */
- (void)lxReuqestSaveUserInfoWithCertNo:(NSString *)certNo present:(NSString *)present completionBlock:(void(^)(LXSaveUserInfoResponseObject *responseModel))block {
    LXSaveUserInfoUrlSessionTask *saveUserInfo = [LXSaveUserInfoUrlSessionTask new];
    saveUserInfo.certNo = certNo;
    saveUserInfo.present = present;
    [saveUserInfo lxReuqestSaveUserInfoWithCompletionBlock:^(LXSaveUserInfoResponseObject *responseModel) {
        block(responseModel);
    }];
}

/**
 退出登录
 
 @param block block
 */
- (void)lxRequestAppCoachLogoutCompletionBlock:(void(^)(LXAppCoachLogoutResponseObject *responseModel))block {
    LXAppCoachLogoutSessionTask *outLoginTask = [[LXAppCoachLogoutSessionTask alloc] init];
    [outLoginTask lxReuqestAppCoachLogoutWithCompletionBlock:^(LXAppCoachLogoutResponseObject *responseModel) {
        block(responseModel);
    }];
}

/**
 检查版本更新
 
 @param title app名称
 @param block block
 */
- (void)lxReuqestVersionUpdateWithTitle:(NSString *)title completionBlock:(void(^)(LXVersionUpdateResponseObject *responseModel))block {
    LXVersionUpdateSessionTask *task = [[LXVersionUpdateSessionTask alloc] init];
    task.title = title;
    [task lxReuqestVersionUpdateWithCompletionBlock:^(LXVersionUpdateResponseObject *responseModel) {
        block(responseModel);
    }];
}
@end
