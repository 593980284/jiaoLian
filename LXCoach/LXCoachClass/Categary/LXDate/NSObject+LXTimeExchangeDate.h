//
//  NSObject+LXTimeExchangeDate.h
//  LXCoach
//
//  Created by lyq on 2018/10/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LXTimeExchangeDate)
/**
 将完整的时间转换为时间戳
 
 @param formateTime 完整的时间
 @param formatter 时间格式
 @return 时间戳
 */
+ (NSInteger)exchangeTimeSwitchTimeStamp:(NSString *)formateTime andFormatter:(NSString *)formatter;

/**
 返回当前时间戳

 @return 时间戳
 */
+ (NSInteger)currentTimeStamp;
@end

NS_ASSUME_NONNULL_END
