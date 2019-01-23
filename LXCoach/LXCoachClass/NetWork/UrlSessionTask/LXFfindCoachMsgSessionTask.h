//
//  LXFfindCoachMsgSessionTask.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXBaseUrlSessionTask.h"

//@class LXFindCoachMsgModel;
@class LXFindCoachMsgResponseObject;

/**
 查询此教练消息列表
 */
@interface LXFfindCoachMsgSessionTask : LXBaseUrlSessionTask
/// 教练证号
@property (nonatomic, copy)NSString *certNo;
/// 操作系统 1：系统消息，2：驾校消息
@property (nonatomic, copy)NSString *type;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger rows;

- (void)lxReuqestFindCoachMsgWithCompletionBlock:(void(^)(LXFindCoachMsgResponseObject *responseModel))block;

@end

@interface LXFindCoachMsgResponseObject : LXNetWorkResponseBaseObject
@property (nonatomic, copy) NSArray * data;
@end
