//
//  LXFfindCoachMsgSessionTask.m
//  LXCoach
//
//  Created by GDD on 2018/9/13.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXFfindCoachMsgSessionTask.h"
#import "LXFindCoachMsgModel.h"

@implementation LXFfindCoachMsgSessionTask

- (void)lxReuqestFindCoachMsgWithCompletionBlock:(void(^)(LXFindCoachMsgResponseObject *responseModel))block {
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindCoachMsg] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXFindCoachMsgResponseObject class] completionBlock:block];
}
@end

@implementation LXFindCoachMsgResponseObject
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [LXFindCoachMsgModel class]
             };
}
@end
