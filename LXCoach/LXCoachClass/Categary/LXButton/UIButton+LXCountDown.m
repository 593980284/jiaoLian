//
//  UIButton+LXCountDown.m
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "UIButton+LXCountDown.h"

@implementation UIButton (LXCountDown)
/**
 倒计时
 
 @param timeLine 倒计时时间
 @param title 正常时显示文字
 @param subTitle 倒计时时显示的文字（不包含秒）
 @param countDoneBlock 倒计时结束时的Block
 @param isInteraction 是否希望倒计时时可交互
 */
- (void)countDownWithTime:(NSInteger)timeLine withTitle:(NSString *)title andCountDownTitle:(NSString *)subTitle countDoneBlock:(CountDoneBlock)countDoneBlock isInteraction:(BOOL)isInteraction{
    __block NSInteger timeout = timeLine; // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (countDoneBlock) {
                    countDoneBlock(self);
                }
                //设置界面的按钮显示 根据自己需求设置
                self.userInteractionEnabled = YES;
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:[UIColor colorWithHexString:@"#309CF5"] forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont systemFontOfSize:15];
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            if (timeout == 60) {
                seconds = 60;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [self setTitle:[NSString stringWithFormat:@"%@s%@",strTime,subTitle] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor colorWithHexString:@"#9A9A9A"] forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont systemFontOfSize:15];
                self.userInteractionEnabled = isInteraction;
                
            });
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

@end
