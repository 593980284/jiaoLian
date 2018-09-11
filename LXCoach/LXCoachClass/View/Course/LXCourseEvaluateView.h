//
//  LXCourseEvaluateView.h
//  LXCoach
//
//  Created by GDD on 2018/9/10.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXCourseEvaluateViewDelegate <NSObject>
- (void)lx_courseAssessNextStep:(NSString *)accessString;
@end

@interface LXCourseEvaluateView : UIView
@property (nonatomic, assign) id <LXCourseEvaluateViewDelegate> delegate;
@end
