//
//  LXFindPassWordDataController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXFindPassWordResponseObject;

@interface LXFindPassWordDataController : NSObject

/// 用户手机号
@property (nonatomic, copy)   NSString *phone;
/// 短信验证码
@property (nonatomic, copy)   NSString *msgCode;

/**
 教练员找回密码第一步

 @param phone 用户手机号
 @param msgCode 短信验证码
 @param block LXFindPassWordResponseObject
 */
- (void)lxReuqestFindPassWordWithPhone:(NSString *)phone msgCode:(NSString *)msgCode completionBlock:(void(^)(LXFindPassWordResponseObject *responseModel))block;

@end
