//
//  LXVersionUpdateSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/21.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXVersionUpdateSessionTask.h"

@implementation LXVersionUpdateSessionTask
- (void)lxReuqestVersionUpdateWithCompletionBlock:(void(^)(LXVersionUpdateResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kVersionUpdate] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXVersionUpdateResponseObject class] completionBlock:block];
}
@end

@implementation LXVersionUpdateResponseObject

@end
