//
//  LXCodeUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXCodeResponseObject;

/**
  获得短信验证码接口
 */
@interface LXCodeUrlSessionTask : LXBaseUrlSessionTask

/// 用户手机号
@property (nonatomic, copy)   NSString *phone;

- (void)lxReuqestCodeWithCompletionBlock:(void(^)(LXCodeResponseObject *responseModel))block;

@end

@interface LXCodeResponseObject : LXNetWorkResponseBaseObject

/// 验证码
@property (nonatomic, copy)  NSString *data;

@end
