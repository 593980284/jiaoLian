//
//  LXChangePhoneNumDataController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXChangePhoneNumDataController.h"
#import "LXChangePhoneNumUrlSessionTask.h"

@implementation LXChangePhoneNumDataController

/**
 教练员更换手机号第一步
 
 @param certNo 教练证
 @param phone 教练旧手机号
 @param msgCode 手机验证码
 @param block LXChangePhoneNumResponseObject
 */
- (void)lxReuqestChangePhoneNumWithCertNo:(NSString *)certNo phone:(NSString *)phone msgCode:(NSString *)msgCode completionBlock:(void(^)(LXChangePhoneNumResponseObject *responseModel))block {
    LXChangePhoneNumUrlSessionTask *changePhoneNumSessionTask = [LXChangePhoneNumUrlSessionTask new];
    changePhoneNumSessionTask.certNo = certNo;
    changePhoneNumSessionTask.phone = phone;
    changePhoneNumSessionTask.msgCode = msgCode;
    [changePhoneNumSessionTask lxReuqestChangePhoneNumWithCompletionBlock:^(LXChangePhoneNumResponseObject *responseModel) {
        block(responseModel);
    }];
}


@end
