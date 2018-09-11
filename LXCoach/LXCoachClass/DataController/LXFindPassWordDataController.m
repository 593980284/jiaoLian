//
//  LXFindPassWordDataController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindPassWordDataController.h"
#import "LXFindPassWordUrlSessionTask.h"

@implementation LXFindPassWordDataController

/**
 教练员找回密码第一步
 
 @param phone 用户手机号
 @param msgCode 短信验证码
 @param block LXFindPassWordResponseObject
 */
- (void)lxReuqestFindPassWordWithPhone:(NSString *)phone msgCode:(NSString *)msgCode completionBlock:(void(^)(LXFindPassWordResponseObject *responseModel))block {
    LXFindPassWordUrlSessionTask *findPassWordSessionTask = [LXFindPassWordUrlSessionTask new];
    findPassWordSessionTask.phone = phone;
    findPassWordSessionTask.msgCode = msgCode;
    [findPassWordSessionTask lxReuqestFindPassWordWithCompletionBlock:^(LXFindPassWordResponseObject *responseModel) {
        block(responseModel);
    }];
}
@end
