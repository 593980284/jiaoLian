//
//  LXFindSingleCoachMsgSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFindSingleCoachMsgSessionTask.h"

@implementation LXFindSingleCoachMsgSessionTask

- (void)lxReuqestFindSingleCoachMsgWithCompletionBlock:(void(^)(LXFindSingleCoachMsgResponseObject *responseModel))block{
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindSingleCoachMsg] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindSingleCoachMsgResponseObject class] completionBlock:block];
}
@end

@implementation LXFindSingleCoachMsgResponseObject

@end
