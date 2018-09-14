//
//  LXFindMyStudentSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindMyStudentSessionTask.h"
#import "LXMyStudentListModel.h"

@implementation LXFindMyStudentSessionTask

- (void)lxReuqestFindMyStudentWithCompletionBlock:(void(^)(LXFindMyStudentResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindMyStudentList] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindMyStudentResponseObject class] completionBlock:block];
}

@end

@implementation LXFindMyStudentResponseObject

@end
