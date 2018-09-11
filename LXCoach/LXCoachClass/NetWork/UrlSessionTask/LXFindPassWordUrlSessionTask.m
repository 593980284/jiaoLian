//
//  LXFindPassWordUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindPassWordUrlSessionTask.h"

@implementation LXFindPassWordUrlSessionTask

- (void)lxReuqestFindPassWordWithCompletionBlock:(void(^)(LXFindPassWordResponseObject *responseModel))block {
    
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindPassWord] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindPassWordResponseObject class] completionBlock:block];
    
}
@end

@implementation LXFindPassWordResponseObject

@end
