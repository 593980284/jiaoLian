//
//  LXIntroMineSubView.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/6.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXIntroMineSubViewDelegate <NSObject>
/**
 确认修改简介

 @param introMessage 修改后的简介
 */
//- (void)lx_alterMineMessage:(NSString *)introMessage;
@end

/**
 个人简介view
 */
@interface LXIntroMineSubView : UIView
//@property (nonatomic, assign) id <LXIntroMineSubViewDelegate> delegate;

/// 个人简介描述
//@property (nonatomic, strong) UITextView *introDetaile;

@end
