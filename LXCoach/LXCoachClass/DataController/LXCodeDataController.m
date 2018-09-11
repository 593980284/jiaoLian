//
//  LXCodeDataController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCodeDataController.h"
#import "LXCodeUrlSessionTask.h"

@implementation LXCodeDataController

/**
 获得短信验证码接口
 
 @param phone 用户手机号
 @param block LXCodeResponseObject
 */
- (void)lxReuqestCodeWithPhone:(NSString *)phone completionBlock:(void(^)(LXCodeResponseObject *responseModel))block {
    LXCodeUrlSessionTask *codeUrlSessionTask = [LXCodeUrlSessionTask new];
    codeUrlSessionTask.phone = phone;
    [codeUrlSessionTask lxReuqestCodeWithCompletionBlock:^(LXCodeResponseObject *responseModel) {
        block(responseModel);
    }];
}

@end
