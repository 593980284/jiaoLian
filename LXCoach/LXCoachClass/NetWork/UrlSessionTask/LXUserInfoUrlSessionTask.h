//
//  LXUserInfoUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXUserInfoResponseObject;
@class LXMineModel;
/**
  获取教练信息接口
 */
@interface LXUserInfoUrlSessionTask : LXBaseUrlSessionTask

/// 教练证
@property (nonatomic, copy)   NSString *certNo;


- (void)lxReuqestUserInfoWithCompletionBlock:(void(^)(LXUserInfoResponseObject *responseModel))block;

@end


@interface LXUserInfoResponseObject : LXNetWorkResponseBaseObject

@property (nonatomic, strong)  LXMineModel *data;

@end
