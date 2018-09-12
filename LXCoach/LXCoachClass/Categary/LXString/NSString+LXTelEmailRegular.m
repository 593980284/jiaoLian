//
//  NSString+LXTelEmailRegular.m
//  LXCoach
//
//  Created by GDD on 2018/9/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "NSString+LXTelEmailRegular.h"

@implementation NSString (LXTelEmailRegular)
/**
 验证邮箱
 
 @param email 邮箱
 @return 是否是邮箱
 */
+ (BOOL)lxIsValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}


/**
 验证电话号码,符合国际号码规则
 
 @param mobileNumbel 电话号码
 @return 是否是电话号码
 */
+ (BOOL)lxIsValidateMobileNumber:(NSString *)mobileNumbel {
    //  首先进行手机号长度的判断
    //  首先去除首尾的空格
    NSString *str = [mobileNumbel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str.length >= 5 && str.length <= 16) {
        NSString *aaa = @"^\\s*\\+?\\s*(\\(\\s*\\d+\\s*\\)|\\d+)(\\s*-?\\s*(\\(\\s*\\d+\\s*\\)|\\s*\\d+\\s*))*\\s*$";
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", aaa];
        if (([regextestct evaluateWithObject:mobileNumbel])) {
            return YES;
        }
        return NO;
    }else{
        return NO;
    }
}


/**
 验证手机号
 
 @param mobilePhoneNumber 手机号
 @return 是否是手机号
 */
+ (BOOL)lxIsValidateMobilePhoneNumber:(NSString *)mobilePhoneNumber {
    if (mobilePhoneNumber.length != 11) {
        return NO;
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobilePhoneNumber];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobilePhoneNumber];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobilePhoneNumber];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else {
            return NO;
        }
    }
}
@end
