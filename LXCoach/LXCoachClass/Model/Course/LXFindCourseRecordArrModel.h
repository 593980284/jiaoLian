//
//  LXFindCourseRecordArrModel.h
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXFindCourseRecordArrModel : NSObject

/// 已完成课程
@property (nonatomic, copy) NSArray *clist;
/// 未完成课程
@property (nonatomic, copy) NSArray *ulist;

@end
