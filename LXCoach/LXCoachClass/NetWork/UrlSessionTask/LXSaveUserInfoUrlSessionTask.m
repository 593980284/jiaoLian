//
//  LXSaveUserInfoUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXSaveUserInfoUrlSessionTask.h"

@implementation LXSaveUserInfoUrlSessionTask

- (void)lxReuqestSaveUserInfoWithCompletionBlock:(void(^)(LXSaveUserInfoResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kSaveUserInfo] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXSaveUserInfoResponseObject class] completionBlock:block];
    
}

@end


@implementation LXSaveUserInfoResponseObject

@end
