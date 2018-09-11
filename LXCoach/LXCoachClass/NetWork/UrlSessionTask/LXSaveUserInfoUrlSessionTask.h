//
//  LXSaveUserInfoUrlSessionTask.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXSaveUserInfoResponseObject;

/**
 保存教练个人简介信息
 */
@interface LXSaveUserInfoUrlSessionTask : LXBaseUrlSessionTask

/// 教练证
@property (nonatomic, copy)   NSString *certNo;
/// 个人简介
@property (nonatomic, copy)   NSString *present;

- (void)lxReuqestSaveUserInfoWithCompletionBlock:(void(^)(LXSaveUserInfoResponseObject *responseModel))block;


@end


@interface LXSaveUserInfoResponseObject : LXNetWorkResponseBaseObject



@end
