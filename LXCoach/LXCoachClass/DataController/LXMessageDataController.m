//
//  LXMessageDataController.m
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMessageDataController.h"
#import "LXFfindCoachMsgSessionTask.h"
#import "LXFindSingleCoachMsgSessionTask.h"

@implementation LXMessageDataController

/**
 查询此教练消息列表
 
 @param certNo 教练证号
 @param type 1：系统消息，2：驾校消息
 @param block responseModel
 */
- (void)lxReuqestFindCoachMsgWithCertNo:(NSString *)certNo andMessageTyep:(NSString *)type completionBlock:(void(^)(LXFindCoachMsgResponseObject *responseModel))block {
    LXFfindCoachMsgSessionTask *task = [[LXFfindCoachMsgSessionTask alloc] init];
    task.certNo = certNo;
    task.type = type;
    task.rows = 500;
    task.page = 1;
    [task lxReuqestFindCoachMsgWithCompletionBlock:^(LXFindCoachMsgResponseObject *responseModel) {
        block(responseModel);
    }];
}

/**
 查询此教练单个消息
 
 @param msgId 消息id主键
 @param block responseModel
 */
- (void)lxReuqestFindSingleCoachMsgWithMsgId:(NSString *)msgId completionBlock:(void(^)(LXFindSingleCoachMsgResponseObject *responseModel))block {
    LXFindSingleCoachMsgSessionTask *task = [[LXFindSingleCoachMsgSessionTask alloc] init];
    task.msgId = msgId;
    [task lxReuqestFindSingleCoachMsgWithCompletionBlock:^(LXFindSingleCoachMsgResponseObject *responseModel) {
        block(responseModel);
    }];
}
@end
