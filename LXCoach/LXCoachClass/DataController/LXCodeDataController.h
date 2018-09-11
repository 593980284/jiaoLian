//
//  LXCodeDataController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXCodeResponseObject;

@interface LXCodeDataController : NSObject

/**
 获得短信验证码接口
 
 @param phone 用户手机号
 @param block LXCodeResponseObject
 */
- (void)lxReuqestCodeWithPhone:(NSString *)phone completionBlock:(void(^)(LXCodeResponseObject *responseModel))block;

@end
