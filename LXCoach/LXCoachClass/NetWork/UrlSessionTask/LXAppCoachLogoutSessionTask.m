//
//  LXAppCoachLogoutSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXAppCoachLogoutSessionTask.h"

@implementation LXAppCoachLogoutSessionTask

- (void)lxReuqestAppCoachLogoutWithCompletionBlock:(void(^)(LXAppCoachLogoutResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kAppCoachLogout] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXAppCoachLogoutResponseObject class] completionBlock:block];
}

@end


@implementation LXAppCoachLogoutResponseObject

@end
