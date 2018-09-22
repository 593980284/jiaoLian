//
//  LXFindSingleCoachMsgSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"
@class LXFindSingleCoachMsgModel;
@class LXFindSingleCoachMsgResponseObject;

/**
 查询此教练单个消息
 */
@interface LXFindSingleCoachMsgSessionTask : LXBaseUrlSessionTask
/// 消息id主键
@property (nonatomic, copy)NSString *msgId;

- (void)lxReuqestFindSingleCoachMsgWithCompletionBlock:(void(^)(LXFindSingleCoachMsgResponseObject *responseModel))block;

@end

@interface LXFindSingleCoachMsgResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, strong) LXFindSingleCoachMsgModel *data;
@end
