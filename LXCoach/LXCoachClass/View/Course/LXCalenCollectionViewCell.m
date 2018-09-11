//
//  LXCalenCollectionViewCell.m
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCalenCollectionViewCell.h"

@implementation LXCalenCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)TodayLabel:(NSIndexPath *)indexPath  comp:(NSDateComponents *)comp  todaycomp:(NSDateComponents *)todaycomp  week_firsday_month:(NSInteger)week_firsday_month number:(NSString *)num todayNumBGcolor:(UIColor *)color andHiddeReservationState:(BOOL)state{
    
    self.numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width/2-30/2, 12+15, 30, 30)];
    self.numberlabel.clipsToBounds = YES;
    self.numberlabel.font = [UIFont systemFontOfSize:16];
    self.numberlabel.layer.cornerRadius = 15;
    [self.contentView addSubview:self.numberlabel];
    self.numberlabel.textAlignment = 1;
    self.numberlabel.text = num;
    if (comp.year == todaycomp.year && todaycomp.month == comp.month && comp.day == todaycomp.day &&indexPath.row ==( week_firsday_month - 1 + comp.day + 7 ) ){
        self.numberlabel.backgroundColor = color;
        self.numberlabel.textColor = [UIColor whiteColor];
    }
    
    self.reservationMarkView = [[UIView alloc] init];
    self.reservationMarkView.frame = CGRectMake(self.contentView.frame.size.width/2-8/2, CGRectGetMaxY(self.numberlabel.frame) + 2, 8, 8);
    [self.contentView addSubview:self.reservationMarkView];
    self.reservationMarkView.backgroundColor = [UIColor orangeColor];
    self.reservationMarkView.clipsToBounds = YES;
    self.reservationMarkView.layer.cornerRadius = 4;
    self.reservationMarkView.hidden = state;
}

-(void)TodayLabelindexPath:(NSIndexPath *)indexPath comp:(NSDateComponents *)comp todaycomp:(NSDateComponents *)todaycomp week_firsday_month:(NSInteger)week_firsday_month number:(NSString *)num textcolor:(UIColor *)color
{
    
    if (comp.year == todaycomp.year && todaycomp.month == comp.month && comp.day == todaycomp.day &&indexPath.row ==( week_firsday_month - 1 + comp.day + 7 ) ){
        
        self.numberlabel.textColor = color;
    }
    
}

@end
