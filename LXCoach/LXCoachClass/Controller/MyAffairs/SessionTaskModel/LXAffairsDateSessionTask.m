//
//  LXAffairsDateSessionTask.m
//  LXCoach
//
//  Created by slardar on 2019/1/20.
//  Copyright © 2019年 LeXiang. All rights reserved.
//

#import "LXAffairsDateSessionTask.h"

@implementation LXAffairsDateSessionTask
-(void)lxReuqestWithCompletionBlock:(void (^)(LXAffairsDateResponseObject * _Nonnull))block{
    NSMutableDictionary *postParameters = [NSMutableDictionary dictionaryWithDictionary:[self yy_modelToJSONObject]];
    [self lxRequestWithUrlString:[NSString stringWithFormat:@"%@%@",kBaseUrl, kFindMyAffairsToHandleDateList] requestType:LXHttpRequestTypePost parameters:postParameters needCache:NO cacheParameters:nil reponseModelClass:[LXAffairsDateResponseObject class] completionBlock:block];
}
@end

@implementation LXAffairsDateResponseObject

@end
