//
//  LXMyCoachEvaluationStudentsSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/17.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXMyCoachEvaluationStudentsSessionTask.h"

@implementation LXMyCoachEvaluationStudentsSessionTask

- (void)lxReuqestMyCoachEvaluationStudentsWithCompletionBlock:(void(^)(LXMyCoachEvaluationStudentsResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kMyCoachEvaluationStudents] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXMyCoachEvaluationStudentsResponseObject class] completionBlock:block];
}
@end

@implementation LXMyCoachEvaluationStudentsResponseObject

@end

