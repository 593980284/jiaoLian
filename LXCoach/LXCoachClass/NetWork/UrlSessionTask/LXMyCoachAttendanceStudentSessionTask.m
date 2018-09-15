//
//  LXMyCoachAttendanceStudentSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/15.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMyCoachAttendanceStudentSessionTask.h"

@implementation LXMyCoachAttendanceStudentSessionTask

- (void)lxReuqestMyCoachAttendanceStudentWithCompletionBlock:(void(^)(LXMyCoachAttendanceStudentResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kMyCoachAttendanceStudent] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXMyCoachAttendanceStudentResponseObject class] completionBlock:block];
}

@end

@implementation LXMyCoachAttendanceStudentResponseObject

@end
