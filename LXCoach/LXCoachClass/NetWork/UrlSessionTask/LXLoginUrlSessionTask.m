//
//  LXLoginUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXLoginUrlSessionTask.h"

@implementation LXLoginUrlSessionTask


- (void)lxReuqestLoginWithCompletionBlock:(void(^)(LXLoginResponseObject *responseModel))block {
    
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kLoginUrl] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXLoginResponseObject class] completionBlock:block];
}

@end

@implementation LXLoginResponseObject


@end
