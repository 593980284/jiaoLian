//
//  LXFindCoachMsgModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXFindCoachMsgModel : NSObject
/// 消息发布内容
@property (nonatomic, copy) NSString *content;
/// 消息发布时间
@property (nonatomic, copy) NSString *date;
/// 消息id主键
@property (nonatomic, assign) NSInteger msgId;
///  2 驾校发布消息 3 教学提醒消息
@property (nonatomic, copy) NSString *msgType;

@end
