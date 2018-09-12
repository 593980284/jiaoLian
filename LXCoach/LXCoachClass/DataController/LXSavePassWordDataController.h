//
//  LXSavePassWordDataController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXSavePassWordResponseObject;

@interface LXSavePassWordDataController : NSObject

/**
 教练员找回密码第二步（保存密码）

 @param phoneNumber 手机号
 @param password 密码
 @param block LXSavePassWordResponseObject
 */
- (void)lxReuqestSavePassWordWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password completionBlock:(void(^)(LXSavePassWordResponseObject *responseModel))block;
@end
