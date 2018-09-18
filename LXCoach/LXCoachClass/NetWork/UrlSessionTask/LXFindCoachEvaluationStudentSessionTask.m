//
//  LXFindCoachEvaluationStudentSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/17.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindCoachEvaluationStudentSessionTask.h"

@implementation LXFindCoachEvaluationStudentSessionTask

- (void)lxReuqestFindCoachEvaluationStudentWithCompletionBlock:(void(^)(LXFindCoachEvaluationStudentResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindCoachEvaluationStudent] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindCoachEvaluationStudentResponseObject class] completionBlock:block];
}

@end

@implementation LXFindCoachEvaluationStudentResponseObject

@end
