//
//  LXCoachEvaluationStudentSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/18.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCoachEvaluationStudentSessionTask.h"

@implementation LXCoachEvaluationStudentSessionTask

- (void)lxReuqestCoachEvaluationStudentWithCompletionBlock:(void(^)(LXCoachEvaluationStudentResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kCoachEvaluationStudent] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXCoachEvaluationStudentResponseObject class] completionBlock:block];
}
@end

@implementation LXCoachEvaluationStudentResponseObject

@end
