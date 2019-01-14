//
//  LX_ImageText_View.h
//  LXCoach
//
//  Created by slardar on 2019/1/12.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LX_ImageText_View : UIView
-(instancetype)initWithImage:(UIImage *)image placehold:(NSString *)placehold;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UITextField *textField;
@end

NS_ASSUME_NONNULL_END
