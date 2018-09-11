//
//  LXCalenCollectionViewCell.h
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXCalenCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong)UILabel * numberlabel;
@property (nonatomic , strong)UILabel * Monthnumberlabel;
/// 预约标记
@property (nonatomic , strong)UIView *reservationMarkView;

-(void)TodayLabel:(NSIndexPath *)indexPath  comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp  week_firsday_month:(NSInteger)week_firsday_month number:(NSString *)num todayNumBGcolor:(UIColor *)color andHiddeReservationState:(BOOL)state;

-(void)TodayLabelindexPath:(NSIndexPath *)indexPath comp:(NSDateComponents *)comp todaycomp:(NSDateComponents *)todaycomp week_firsday_month:(NSInteger)week_firsday_month number:(NSString *)num textcolor:(UIColor *)color;

@end
