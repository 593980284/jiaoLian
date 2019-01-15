//
//  LX_Step_View.h
//  LXCoach
//
//  Created by slardar on 2019/1/15.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LX_Step_View : UIView
@property (nonatomic,strong) UIImageView *stepOneImgView;
@property (nonatomic,strong) UIImageView *stepTwoImgView;
@property (nonatomic,strong) UILabel *explainLabel;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

NS_ASSUME_NONNULL_END
