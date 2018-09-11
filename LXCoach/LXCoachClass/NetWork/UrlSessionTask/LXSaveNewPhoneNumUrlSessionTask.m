//
//  LXSaveNewPhoneNumUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXSaveNewPhoneNumUrlSessionTask.h"

@implementation LXSaveNewPhoneNumUrlSessionTask

- (void)lxReuqestSaveNewPhoneNumWithCompletionBlock:(void(^)(LXSaveNewPhoneNumResponseObject *responseModel))block {
    
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kSavePhoneNum] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXSaveNewPhoneNumResponseObject class] completionBlock:block];
}

@end


@implementation LXSaveNewPhoneNumResponseObject

@end
