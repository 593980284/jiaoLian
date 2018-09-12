//
//  LXSavePassWordUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXSavePassWordResponseObject;


/**
 教练员找回密码第二步（保存密码）
 */
@interface LXSavePassWordUrlSessionTask : LXBaseUrlSessionTask


/// 手机号
@property (nonatomic, copy)   NSString *phone;
/// 密码
@property (nonatomic, copy)   NSString *password;

- (void)lxReuqestSavePassWordWithCompletionBlock:(void(^)(LXSavePassWordResponseObject *responseModel))block;

@end

@interface LXSavePassWordResponseObject : LXNetWorkResponseBaseObject


@end
