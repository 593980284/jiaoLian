//
//  LXVersionUpdateSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/21.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXVersionUpdateResponseObject;
@class LXVersionUpdateModel;

/**
 检查更新
 */
@interface LXVersionUpdateSessionTask : LXBaseUrlSessionTask
/// 版本名称
@property (nonatomic,copy)NSString *title;

- (void)lxReuqestVersionUpdateWithCompletionBlock:(void(^)(LXVersionUpdateResponseObject *responseModel))block;

@end

@interface LXVersionUpdateResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, strong) LXVersionUpdateModel *data;
@end
