//
//  LXChangeOrFindPasswordView.h
//  LXCoach
//
//  Created by 李玉琴 on 2018/9/5.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXChangeOrFindPasswordViewDelegate <NSObject>
/**
 点击确认

 @param testCode 验证码
 */
- (void)lx_clickAffirmButton:(NSString *)testCode;
@end

@interface LXChangeOrFindPasswordView : UIView
@property (nonatomic, assign) id <LXChangeOrFindPasswordViewDelegate> delegate;
@property (nonatomic, strong) UITextField *acountTextField;
@end
