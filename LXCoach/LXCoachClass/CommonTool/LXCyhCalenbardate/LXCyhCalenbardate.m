//
//  LXCyhCalenbardate.m
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCyhCalenbardate.h"

@implementation LXCyhCalenbardate
//计算一个月的总天数
- (NSInteger)daysInthisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return totaldaysInMonth.length;
}

//计算年-月-日
- (NSDateComponents *)year_month_todayInthisMonth:(NSDate *)date
{
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";//HH:mm:ss
    //    NSString * dateStr = [df stringFromDate:date];
    //    NSLog(@"今天是==:%@",dateStr);
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSDateComponents * coms =  [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal|NSCalendarUnitWeekOfMonth|NSCalendarUnitYearForWeekOfYear fromDate:date];
    
    return coms;
    
}

//一个月的第一天是星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];
    
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    return firstWeekday -1;
}


//计算一个月有几个星期
- (NSUInteger)numberOfWeeksInCurrentMonth:(NSDate *)date
{
    NSUInteger weeks = 0;
    NSUInteger weekday = [self firstWeekdayInThisMonth:date];
    if (weekday > 0) {
        weeks += 1;
    }
    NSUInteger monthDays = [self daysInthisMonth:date];
    weeks = weeks + (monthDays - weekday)/7;
    if ((monthDays - weekday) %7 > 0) {
        weeks += 1;
    }
    
    return weeks;
}

+ (NSString *)weekday:(NSDate *)date
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    NSDateComponents * coms =  [cal components:NSCalendarUnitWeekday fromDate:date];
    NSMutableString * strOfweekDay = [NSMutableString new];
    
    switch (coms.weekday) {
            case 1:
        {
            [strOfweekDay setString:@"星期日"];
            break;
        }
            case 2:
        {
            [strOfweekDay setString:@"星期一"];
            break;
        }
            case 3:
        {
            [strOfweekDay setString:@"星期二"];
            break;
        }
            case 4:
        {
            [strOfweekDay setString:@"星期三"];
            break;
        }
            case 5:
        {
            [strOfweekDay setString:@"星期四"];
            break;
        }
            case 6:
        {
            [strOfweekDay setString:@"星期五"];
            break;
        }
            case 7:
        {
            [strOfweekDay setString:@"星期六"];
            break;
        }
            
        default:
            break;
    }
    
    return strOfweekDay;
}

//上个月的日历
- (NSDate *)lastMonthDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
    
    [components setDay:1];
    if ([components month] == 1) {
        [components setMonth:12];
        [components setYear:[components year] - 1];
    } else {
        [components setMonth:[components month] - 1];
    }
    NSDate *lastMonth = [calendar dateFromComponents:components];
    
    return lastMonth;
}

//下个月的日历
- (NSDate *)nextMonthDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday|NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
    [components setDay:1];
    if ([components month] == 12) {
        [components setMonth:1];
        [components setYear:[components year] + 1];
    } else {
        [components setMonth:[components month] + 1];
        
    }
    NSDate *lastMonth = [calendar dateFromComponents:components];
    return lastMonth;
}

- (NSDate *)lastYeasDate:(NSDate *)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
    
    [components setDay:31];
    
    [components setMonth:12];
    [components setYear:[components year] - 1];
    
    NSDate *lastYeas = [calendar dateFromComponents:components];
    
    return lastYeas;
    
}
- (NSDate *)nextyeasDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday|NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
    [components setDay:1];
    
    [components setMonth:1];
    [components setYear:[components year] + 1];
    
    NSDate * nextyeas = [calendar dateFromComponents:components];
    return nextyeas;
    
}


#pragma mark - 将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return timeSp;
    
}
/// 根据日期转为 NSDate
+ (NSDate *)timeSwitchDate:(NSString *)formatTime andFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    return date;
}

// 截取当前的日 （date格式：年-月-日）
+ (NSString *)obtainDateDay:(NSString *)date {
    NSArray *arr = [date componentsSeparatedByString:@"-"];
    NSString *currentDate = [arr lastObject];
    return currentDate;
}
// 截取当前的年-月 （date格式：年-月-日）
+ (NSString *)obtainDateYearAndMonth:(NSString *)date {
    NSArray *arr = [date componentsSeparatedByString:@"-"];
    NSString *currentDate = [NSString stringWithFormat:@"%@-%@",[arr firstObject],arr[1]];
    return currentDate;
}
@end
