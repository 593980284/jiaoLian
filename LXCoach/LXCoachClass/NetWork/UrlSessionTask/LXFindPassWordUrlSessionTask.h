//
//  LXFindPassWordUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXFindPassWordResponseObject;

/**
 教练员找回密码第一步
 */
@interface LXFindPassWordUrlSessionTask : LXBaseUrlSessionTask

/// 用户手机号
@property (nonatomic, copy)   NSString *phone;
/// 短信验证码
@property (nonatomic, copy)   NSString *msgCode;

- (void)lxReuqestFindPassWordWithCompletionBlock:(void(^)(LXFindPassWordResponseObject *responseModel))block;

@end

@interface LXFindPassWordResponseObject : LXNetWorkResponseBaseObject


@end
