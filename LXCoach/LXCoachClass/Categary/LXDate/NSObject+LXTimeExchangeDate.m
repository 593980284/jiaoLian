//
//  NSObject+LXTimeExchangeDate.m
//  LXCoach
//
//  Created by lyq on 2018/10/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "NSObject+LXTimeExchangeDate.h"

@implementation NSObject (LXTimeExchangeDate)

+ (NSInteger)exchangeTimeSwitchTimeStamp:(NSString *)formateTime andFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formateTime];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:format];
    // 后台返回时间段算d出的 时间戳
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+ (NSInteger)currentTimeStamp {
    NSDate *datenow = [NSDate date];
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    return timeSp;
}
@end
