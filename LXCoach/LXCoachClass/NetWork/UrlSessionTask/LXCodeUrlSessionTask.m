//
//  LXCodeUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXCodeUrlSessionTask.h"

@implementation LXCodeUrlSessionTask

- (void)lxReuqestCodeWithCompletionBlock:(void(^)(LXCodeResponseObject *responseModel))block {
    
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kCodeUrl] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXCodeResponseObject class] completionBlock:block];
}

@end


@implementation LXCodeResponseObject


@end
