//
//  LXChangePassWordUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXChangePassWordResponseObject;

/**
  教练修改密码接口
 */
@interface LXChangePassWordUrlSessionTask : LXBaseUrlSessionTask

/// 教练证
@property (nonatomic, copy)   NSString *certNo;
/// 教练旧密码
@property (nonatomic, copy)   NSString *oldPassword;
/// 教练新密码
@property (nonatomic, copy)   NSString *password;


- (void)lxReuqestChangePassWordWithCompletionBlock:(void(^)(LXChangePassWordResponseObject *responseModel))block;

@end


@interface LXChangePassWordResponseObject : LXNetWorkResponseBaseObject


@end
