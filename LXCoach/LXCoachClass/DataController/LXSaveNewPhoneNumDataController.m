//
//  LXSaveNewPhoneNumDataController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXSaveNewPhoneNumDataController.h"
#import "LXSaveNewPhoneNumUrlSessionTask.h"

@implementation LXSaveNewPhoneNumDataController


/**
 教练员更换手机号第二步
 
 @param certNo 教练证
 @param phone 教练新手机号
 @param msgCode 手机验证码
 @param block LXSaveNewPhoneNumResponseObject
 */
- (void)lxReuqestSaveNewPhoneNumWithCertNo:(NSString *)certNo phone:(NSString *)phone msgCode:(NSString *)msgCode completionBlock:(void(^)(LXSaveNewPhoneNumResponseObject *responseModel))block {
    LXSaveNewPhoneNumUrlSessionTask *saveNewPhoneNum = [LXSaveNewPhoneNumUrlSessionTask new];
    saveNewPhoneNum.certNo = certNo;
    saveNewPhoneNum.phone = phone;
    saveNewPhoneNum.msgCode = msgCode;
    [saveNewPhoneNum lxReuqestSaveNewPhoneNumWithCompletionBlock:^(LXSaveNewPhoneNumResponseObject *responseModel) {
        block(responseModel);
    }];
}

@end
