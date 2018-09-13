//
//  LXFindSingleCoachMsgModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXFindSingleCoachMsgModel : NSObject

/// 消息发布内容
@property (nonatomic, copy) NSString *content;
/// 消息发布时间
@property (nonatomic, copy) NSString *date;
/// 2 驾校发布消息 3 教学提醒消息
@property (nonatomic, assign) NSInteger msgType;
/// 消息标题
@property (nonatomic, copy) NSString *title;
/// 约课id
@property (nonatomic, copy) NSString *appointmentId;

@end
