//
//  LXCyhCalenbarview.h
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXGetdataStringDelegate <NSObject>
/**
 *  获取当前或选择日期
 *
 *  @param datestring 日期字符串
 */
- (void)getDatestring:(NSString *)datestring;

@end

@interface LXCyhCalenbarview : UIView
/**
 *  按天计算的日历形式
 */
@property (nonatomic , strong)LXCyhCalenbarview * daycalenbarview;

@property (nonatomic , strong)UILabel * daycalenlabel;
@property (nonatomic , strong)UILabel * Y_M_Dlabel;
@property (nonatomic , strong)NSMutableArray * datesource;
@property (nonatomic , assign)NSInteger  week_firsday_month;//一个月的第一天是星期几
@property (nonatomic , assign)NSInteger days;//总天数
@property (nonatomic , copy)NSString * weekstr;//星期几
@property (nonatomic , strong) NSDateComponents * comp ;
@property (nonatomic , assign)NSInteger offpage;//计算当天在第几页

/**
 *  星期排列背景颜色
 */
@property (nonatomic , strong)UIColor * WeekBGcolor;
/**
 *  日历背景颜色（按天计算）
 */
@property (nonatomic , strong)UIColor * calenbarBGcolor;
/**
 *  被选中的日期圆点颜色
 */
@property (nonatomic , strong)UIColor * SelecNumBGcolor;
/**
 *  当天日期圆点颜色
 */
@property (nonatomic , strong)UIColor * todayNumBGcolor;
/**
 *  当前日期数字颜色
 */
@property (nonatomic , strong)UIColor * todaytextColor;

/**
 *  获取日期
 */
@property (nonatomic , weak)id<LXGetdataStringDelegate> daydelegate;//协议回调


/**
 *  注册日历（按天计算）
 */
- (void)daycalenbarviewNSdate;
/**
 *  初始化日历，如果日历小于120.0的高度将默认为120.0高度
 *
 *  @param frame 日历位置大小
 *
 *  @return self
 */
- (id)initD_calenbarframe:(CGRect)frame;

@end
