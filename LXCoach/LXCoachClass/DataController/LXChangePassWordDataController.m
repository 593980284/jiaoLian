//
//  LXChangePassWordDataController.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXChangePassWordDataController.h"
#import "LXChangePassWordUrlSessionTask.h"

@implementation LXChangePassWordDataController

- (void)lxReuqestChangePassWordWithCertNo:(NSString *)certNo oldPassword:(NSString *)oldPassword password:(NSString *)password completionBlock:(void(^)(LXChangePassWordResponseObject *responseModel))block {
    LXChangePassWordUrlSessionTask *changePassWordSessionTask = [LXChangePassWordUrlSessionTask new];
    changePassWordSessionTask.certNo = certNo;
    changePassWordSessionTask.oldPassword = oldPassword;
    changePassWordSessionTask.password = password;
    [changePassWordSessionTask lxReuqestChangePassWordWithCompletionBlock:^(LXChangePassWordResponseObject *responseModel) {
        block(responseModel);
    }];
}


@end
