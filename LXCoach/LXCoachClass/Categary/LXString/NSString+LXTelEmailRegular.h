//
//  NSString+LXTelEmailRegular.h
//  LXCoach
//
//  Created by GDD on 2018/9/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LXTelEmailRegular)
/**
 验证邮箱
 
 @param email 邮箱
 @return 是否是邮箱
 */
+ (BOOL)lxIsValidateEmail:(NSString *)email;


/**
 验证电话号码,符合国际号码规则
 
 @param mobileNumbel 电话号码
 @return 是否是电话号码
 */
+ (BOOL)lxIsValidateMobileNumber:(NSString *)mobileNumbel;


/**
 验证手机号
 
 @param mobilePhoneNumber 手机号
 @return 是否是手机号
 */
+ (BOOL)lxIsValidateMobilePhoneNumber:(NSString *)mobilePhoneNumber;
@end
