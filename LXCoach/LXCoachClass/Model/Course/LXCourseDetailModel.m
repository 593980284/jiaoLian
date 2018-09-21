//
//  LXCourseDetailModel.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/9.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCourseDetailModel.h"

@implementation LXCourseDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LXCourseToStudentModel class]
             
             };
}
@end

@implementation LXCourseToStudentModel

@end
