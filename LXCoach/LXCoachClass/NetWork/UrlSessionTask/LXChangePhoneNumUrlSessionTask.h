//
//  LXChangePhoneNumUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXChangePhoneNumResponseObject;

/**
  教练员更换手机号第一步
 */
@interface LXChangePhoneNumUrlSessionTask : LXBaseUrlSessionTask

/// 教练证
@property (nonatomic, copy)   NSString *certNo;
/// 教练旧手机号
@property (nonatomic, copy)   NSString *phone;
/// 手机验证码
@property (nonatomic, copy)   NSString *msgCode;

- (void)lxReuqestChangePhoneNumWithCompletionBlock:(void(^)(LXChangePhoneNumResponseObject *responseModel))block;

@end

@interface LXChangePhoneNumResponseObject : LXNetWorkResponseBaseObject


@end
