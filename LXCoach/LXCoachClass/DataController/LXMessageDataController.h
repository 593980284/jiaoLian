//
//  LXMessageDataController.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXFindCoachMsgResponseObject;
@class LXFindSingleCoachMsgResponseObject;

/**
 我的消息DataController
 */
@interface LXMessageDataController : NSObject

/**
 查询此教练消息列表

 @param certNo 教练证号
 @param type 1：系统消息，2：驾校消息
 @param block responseModel
 */
- (void)lxReuqestFindCoachMsgWithCertNo:(NSString *)certNo andMessageTyep:(NSString *)type completionBlock:(void(^)(LXFindCoachMsgResponseObject *responseModel))block;

/**
 查询此教练单个消息

 @param msgId 消息id主键
 @param block responseModel
 */
- (void)lxReuqestFindSingleCoachMsgWithMsgId:(NSString *)msgId completionBlock:(void(^)(LXFindSingleCoachMsgResponseObject *responseModel))block;

@end
