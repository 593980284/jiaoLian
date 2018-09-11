//
//  LXSavePassWordUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXSavePassWordUrlSessionTask.h"

@implementation LXSavePassWordUrlSessionTask

- (void)lxReuqestSavePassWordWithCompletionBlock:(void(^)(LXSavePassWordResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kSavePassWord] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXSavePassWordResponseObject class] completionBlock:block];
    
}
@end


@implementation LXSavePassWordResponseObject

@end
