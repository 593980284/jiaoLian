//
//  LXCyhCalenbardate.h
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCyhCalenbardate : NSObject
//计算一个月的天数
- (NSInteger)daysInthisMonth:(NSDate *)date;
//计算年月日，星期（只呈现1，2，3，4。。。。）
- (NSDateComponents *)year_month_todayInthisMonth:(NSDate *)date;
//一个月的第一天是星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
//星期几
+ (NSString *)weekday:(NSDate *)date;
//一个月有多少星期
- (NSUInteger)numberOfWeeksInCurrentMonth:(NSDate *)date;
//上个月日历
- (NSDate *)lastMonthDate:(NSDate *)date;
//下个月的日历
- (NSDate *)nextMonthDate:(NSDate *)date;

//下一年的月历
- (NSDate *)nextyeasDate:(NSDate *)date;
//上一年的月历
- (NSDate *)lastYeasDate:(NSDate *)date;

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
/// 根据日期转为 NSDate
+ (NSDate *)timeSwitchDate:(NSString *)formateTime andFormatter:(NSString *)format;

// 截取当前的日
+ (NSString *)obtainDateDay:(NSString *)date;
// 截取当前的年-月
+ (NSString *)obtainDateYearAndMonth:(NSString *)date;
@end
