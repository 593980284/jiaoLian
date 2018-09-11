//
//  LXSaveNewPhoneNumUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXSaveNewPhoneNumResponseObject;

/**
 教练员更换手机号第二步
 */
@interface LXSaveNewPhoneNumUrlSessionTask : LXBaseUrlSessionTask

/// 教练证
@property (nonatomic, copy)   NSString *certNo;
/// 教练新手机号

@property (nonatomic, copy)   NSString *phone;
/// 手机验证码
@property (nonatomic, copy)   NSString *msgCode;

- (void)lxReuqestSaveNewPhoneNumWithCompletionBlock:(void(^)(LXSaveNewPhoneNumResponseObject *responseModel))block;


@end

@interface LXSaveNewPhoneNumResponseObject : LXNetWorkResponseBaseObject


@end
