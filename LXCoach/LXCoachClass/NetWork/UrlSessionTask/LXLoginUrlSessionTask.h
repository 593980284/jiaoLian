//
//  LXLoginUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXLoginResponseObject;
@class LXMineModel;

@interface LXLoginUrlSessionTask : LXBaseUrlSessionTask

/// 教练证号
@property (nonatomic, copy)   NSString *certNo;
/// 用户密码
@property (nonatomic, copy)   NSString *password;

- (void)lxReuqestLoginWithCompletionBlock:(void(^)(LXLoginResponseObject *responseModel))block;

@end


@interface LXLoginResponseObject : LXNetWorkResponseBaseObject

@property (nonatomic, strong)  LXMineModel *data;

@end

