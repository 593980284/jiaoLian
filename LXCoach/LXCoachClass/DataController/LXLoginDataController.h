//
//  LXLoginDataController.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXLoginResponseObject;

@interface LXLoginDataController : NSObject

/**
 教练账号密码接口

 @param certNo 教练证号
 @param password 用户密码
 @param block LXLoginResponseObject
 */
- (void)lxReuqestLoginWithCertNo:(NSString *)certNo password:(NSString *)password completionBlock:(void(^)(LXLoginResponseObject *responseModel))block;




@end
