//
//  LXUploadCoachImageSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/11.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXUploadCoachImageSessionTask.h"

@implementation LXUploadCoachImageSessionTask

- (void)lxReuqestUploadCoachImageWithCompletionBlock:(void(^)(LXUploadCoachImageResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kUploadCoachImage] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXUploadCoachImageResponseObject class] completionBlock:block];
}

@end

@implementation LXUploadCoachImageResponseObject


@end
