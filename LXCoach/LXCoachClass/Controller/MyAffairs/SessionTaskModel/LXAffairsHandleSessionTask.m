//
//  LXAffairsHandleSessionTask.m
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXAffairsHandleSessionTask.h"

@implementation LXAffairsHandleSessionTask
-(void)lxReuqestWithCompletionBlock:(void (^)(LXAffairsHandleResponseObject * _Nonnull))block{
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindMyAffairsToHandleList] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXAffairsHandleResponseObject class] completionBlock:block];
}
@end

@implementation LXAffairsHandleResponseObject


@end
