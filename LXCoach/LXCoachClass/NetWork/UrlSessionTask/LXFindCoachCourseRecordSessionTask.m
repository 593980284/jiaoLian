//
//  LXFindCoachCourseRecordSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindCoachCourseRecordSessionTask.h"
#import "LXFindCourseRecordModel.h"

@implementation LXFindCoachCourseRecordSessionTask

- (void)lxReuqestFindCoachCourseRecordWithCompletionBlock:(void(^)(LXFindCoachCourseResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindCoachCourseRecord] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindCoachCourseResponseObject class] completionBlock:block];
}
@end


@implementation LXFindCoachCourseResponseObject

@end

