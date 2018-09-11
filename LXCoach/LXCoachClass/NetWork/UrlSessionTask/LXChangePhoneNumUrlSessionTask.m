//
//  LXChangePhoneNumUrlSessionTask.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXChangePhoneNumUrlSessionTask.h"

@implementation LXChangePhoneNumUrlSessionTask

- (void)lxReuqestChangePhoneNumWithCompletionBlock:(void(^)(LXChangePhoneNumResponseObject *responseModel))block {
    
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kChangePhoneNum] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXChangePhoneNumResponseObject class] completionBlock:block];
}

@end

@implementation LXChangePhoneNumResponseObject

@end
