//
//  LXUserInfoUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXUserInfoUrlSessionTask.h"

@implementation LXUserInfoUrlSessionTask

- (void)lxReuqestUserInfoWithCompletionBlock:(void(^)(LXUserInfoResponseObject *responseModel))block {
    
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kUserInfo] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXUserInfoResponseObject class] completionBlock:block];
    
}
@end


@implementation LXUserInfoResponseObject

@end
