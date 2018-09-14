//
//  LXFindMyCouseListByDateSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/14.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindMyCouseListByDateSessionTask.h"

@implementation LXFindMyCouseListByDateSessionTask

- (void)lxReuqestFindMyCouseListByDateWithCompletionBlock:(void(^)(LXFindMyCouseListByDateResponseObject *responseModel))block{
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kfindMyCouseListByDate] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindMyCouseListByDateResponseObject class] completionBlock:block];
}

@end

@implementation LXFindMyCouseListByDateResponseObject


@end
