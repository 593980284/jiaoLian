//
//  LXLoginDataController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXLoginDataController.h"
#import "LXLoginUrlSessionTask.h"

@implementation LXLoginDataController

/**
 登录接口
 
 @param certNo 教练证号
 @param password 用户密码
 @param block LXLoginResponseObject
 */
- (void)lxReuqestLoginWithCertNo:(NSString *)certNo password:(NSString *)password completionBlock:(void(^)(LXLoginResponseObject *responseModel))block {
    LXLoginUrlSessionTask *loginSessionTask = [LXLoginUrlSessionTask new];
    loginSessionTask.certNo = certNo;
    loginSessionTask.password = password;
    [loginSessionTask lxReuqestLoginWithCompletionBlock:^(LXLoginResponseObject *responseModel) {
        block(responseModel);
    }];
    
}



@end
